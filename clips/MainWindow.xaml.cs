using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Mommosoft.ExpertSystem;

namespace clips
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        Localization l = new Localization();
        private Mommosoft.ExpertSystem.Environment clips = new Mommosoft.ExpertSystem.Environment();
        private string lastRelationAsserted = "";
        private string relationAsserted;
        public MainWindow()
        {
            InitializeComponent();
            clips.Load("piwo.clp");
            clips.Reset();
            clips.Run(1);
        }

        private void OnLoad(object sender, RoutedEventArgs e)
        {
            NextUIState();
        }

        private void OnClickButton(object sender, RoutedEventArgs e)
        {
            Button button = sender as Button;

            if (button.Tag.Equals("Next"))
            {
                if (choicesPanel.Children.Count != 0)
                {
                   String  theAnswer = (String)GetCheckedChoiceButton().Tag;
                   clips.AssertString("(" + relationAsserted + " " + theAnswer + ")");
                }
                else
                {
                    clips.AssertString("(start)");
                }
                clips.Run(1);
                NextUIState();

            }
            else if (button.Tag.Equals("Restart"))
            {
                clips.Reset();
                clips.Run(1);
                NextUIState();
            }
        }

        private void NextUIState()
        {
            String evalStr = "(find-fact ((?f UI-state)) TRUE)";
            FactAddressValue fv = (FactAddressValue)((MultifieldValue)clips.Eval(evalStr))[0];


            if (fv.GetFactSlot("state").ToString().Equals("final"))
            {
                nextButton.Tag = "Restart";
                nextButton.Content = "Restart";
                choicesPanel.Visibility = Visibility.Collapsed;
            }
            else if (fv.GetFactSlot("state").ToString().Equals("initial"))
            {
                nextButton.Tag = "Next";
                nextButton.Content = "Next >";
                choicesPanel.Visibility = Visibility.Collapsed;
            }
            else
            {
                nextButton.Tag = "Next";
                nextButton.Content = "Next >";
                choicesPanel.Visibility = Visibility.Visible;
            }

            choicesPanel.Children.Clear();

            relationAsserted = fv.GetFactSlot("relation-asserted").ToString();

            if (relationAsserted == lastRelationAsserted)
            {
                clips.Run(1);
                NextUIState();
                return;
            }

            lastRelationAsserted = relationAsserted;

            MultifieldValue va = (MultifieldValue)fv.GetFactSlot("valid-answers");


            String selected = fv.GetFactSlot("response").ToString();

            foreach(var item in va)
            {
                RadioButton rButton = new RadioButton();
                rButton.Content = l[item.ToString()];
                rButton.IsChecked = item.ToString() == selected;
                rButton.Tag = item.ToString();
                rButton.Visibility = Visibility.Visible;
                rButton.Margin = new Thickness(5);
                choicesPanel.Children.Add(rButton);
            }

            messageTextBox.Text = l[fv.GetFactSlot("display").ToString()];

        }

        private RadioButton GetCheckedChoiceButton()
        {
            foreach (RadioButton control in choicesPanel.Children)
            {
                if (control.IsChecked == true)
                { return control; }
            }

            return null;
        }
    }
}
