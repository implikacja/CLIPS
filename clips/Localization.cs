using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace clips
{
    class Localization
    {

            private readonly Dictionary<string, string> translations;
            public Localization()
            {
                translations = File.ReadAllLines("resources.resources")
                    .Where(x => !string.IsNullOrWhiteSpace(x))
                    .Select(x => x.Split(new char[] { '=' }, StringSplitOptions.RemoveEmptyEntries))
                    .ToDictionary(x => x[0].ToLower(), x => x[1]);
            }

            public string this[string key]
            {
                get
                {
                    if (translations.ContainsKey(key.ToLower()))
                        return translations[key.ToLower()];
                    else
                        return key;
                }
            }
        }
}