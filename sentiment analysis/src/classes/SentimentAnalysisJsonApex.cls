public class SentimentAnalysisJsonApex {

    public class SentimentAnalysisApex {
        public List<Sentiment_analysis> sentiment_analysis;
    }

    public class Negative {
        public String sentiment;
        public String topic;
        public Double score;
        public String original_text;
        public Integer original_length;
        public String normalized_text;
        public Integer normalized_length;
        public Integer offset;
    }

    public class Positive {
        public String sentiment;
        public String topic;
        public Double score;
        public String original_text;
        public Integer original_length;
        public String normalized_text;
        public Integer normalized_length;
        public Integer offset;
    }

    public class Aggregate {
        public String sentiment;
        public Double score;
    }

    public class Sentiment_analysis {
        public List<Positive> positive;
        public List<Negative> negative;
        public Aggregate aggregate;
    }

    
    public static SentimentAnalysisApex parse(String json) {
        return (SentimentAnalysisApex) System.JSON.deserialize(json, SentimentAnalysisApex.class);
    }
}