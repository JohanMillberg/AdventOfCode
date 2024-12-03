namespace AdventOfCode2024.days
{
    public class Day1
    {
        private readonly string[] input;
        private readonly List<int> leftList;
        private readonly List<int> rightList;
        public Day1()
        {
            input = File.ReadAllLines("inputs/day1.txt");
            leftList = new List<int>();
            rightList = new List<int>();
            foreach (string line in input)
            {
                var splitString = line.Split("   ");
                leftList.Add(int.Parse(splitString[0]));
                rightList.Add(int.Parse(splitString[1]));
            }
        }

        public string SolvePartOne()
        {
            var sortedLeft = leftList.OrderBy(i => i).ToList();
            var sortedRight = rightList.OrderBy(i => i).ToList();
            int result = sortedLeft.Zip(sortedRight, (left, right) => Math.Abs(left - right)).Sum();
            return result.ToString();
        }
        public string SolvePartTwo()
        {
            var counts = new Dictionary<int, int>();
            foreach (int number in leftList)
            {
                if (counts.ContainsKey(number)) continue;
                counts.Add(number, rightList.Count(n => n == number));
            }
            int result = counts.Sum(pair => pair.Key * pair.Value);
            return result.ToString();
        }
    }
}