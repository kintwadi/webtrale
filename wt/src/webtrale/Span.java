package webtrale;

import java.util.ArrayList;
import java.util.Comparator;

/**
 * A Span is a partial analysis in the parse chart.
 *
 * @author niko
 */
public class Span {

    String[] tokens;
    int length;
    ArrayList<Integer> beginIdxs;
    String ruleName;
    int resultId; // The <result id='ID'

    public Span(String[] tokens, int length, ArrayList<Integer> beginIdxs, String ruleName, int resultId) {
        this.tokens = tokens;
        this.length = length;
        this.beginIdxs = beginIdxs;
        this.ruleName = ruleName;
        this.resultId = resultId;
    }

    
    
    public String[] getTokens() {
        return tokens;
    }

    public int getLength() {
        return length;
    }

    public ArrayList<Integer> getBeginIdxs() {
        return beginIdxs;
    }

    public String getRuleName() {
        return ruleName;
    }

    public int getResultId() {
        return resultId;
    }

    @Override
    public String toString() {
        return "Span{" + "tokens=" + tokens + ", length=" + length + ", beginIdxs=" + beginIdxs + ", ruleName=" + ruleName + ", resultId=" + resultId + '}';
    }

    
    

    public static Comparator<Span> getCompByName() {
        Comparator comp = new Comparator<Span>() {
            @Override
            public int compare(Span sp1, Span sp2) {
                if (sp1.length < sp2.length) {
                    return 1;
                } else if (sp1.length > sp2.length) {
                    return -1;
                } else {
                    return 0;
                }
            }
        };
        return comp;
    }
}
