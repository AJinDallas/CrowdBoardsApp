<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="FAQ.aspx.vb" Inherits="CrowdBoardsApp.FAQ"
    MasterPageFile="~/MasterPage/SiteMaster.Master" Title="FAQ" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <title>FAQ</title>
    <style type="text/css">
        .pContent
        {
            width: 800px;
            margin-left: 280px;
            text-align: justify;
            font-size: larger;
        }
        
        .spanHeader
        {
            font-weight: 700;
            font-size: larger;
        }
        .spanMargin
        {
            margin-left: 10px;
        }        
        #accrodion
        {
            width: 600px;
            height: auto;
            border: solid 1px;
            padding: 10px;
            margin: 0 auto;
        }       
        .acc2
        {
            display: none;
            height: 225px;
            font:inherit;
        }
        .accHead
        {           
            width: 100%;            
            font-size: 1.5em;
            font-weight: 100;
            line-height: 1.2em;
        }
        
        
        
    </style>
   
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="BodyContent" runat="Server">  
   
     <script src="js/jquery-ui.js" type="text/javascript"></script>
    <script type="text/javascript" language="javascript">
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_endRequest(function () {
            $("#accordion").accordion();
            HideShow();
        });
        $(document).ready(function () {
            $("#accordion").accordion();
            HideShow();
        });
        function HideShow() {

            // var index = document.getElementById("hdnIndex").value;
            //alert(index);
            $("#accordion").accordion("option", "active");
        }
         
    </script>
  
    <div class="main-body">
        <!--        Main Body     -->
        <br />
        <h1>
            Frequently Asked Questions (FAQ)</h1>
        <br /><br />
        <div style="width: 100%;">
            <div id="accordion">
                <div class="accHead">
                    1. Why is CrowdBoarders so different from the traditional Crowdfunding Platforms?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    CrowdBoarders is the <b>“World’s First Social Investing Network”</b> which was purposely
                    designed and built to create a new <b>Crowdfunding Eco-System</b>, this offers everyone
                    the chance to <b>join, participate, learn, create, invest and connect</b> with likeminded
                    people worldwide using over <b>50 new social features</b> designed specifically
                    for pure enjoyment and most importantly to provide the chance for <b>anyone to make
                        a difference in this world</b> by using the best place possible to showcase
                    their creative ideas and raise the necessary online funds to make them swiftly become
                    a reality.
                </div>
                <div class="accHead">
                    2. Who is a CrowdBoarder and how do I become one?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    That’s simple <b>Everyone is a CrowdBoarder</b>, all you have to do is <b>create a login</b>,
                    then you are ready to go, once inside CrowdBoarders you are free to enjoy all the
                    <b>social interaction</b> you want and <b>invest in</b> as many exciting opportunities
                    as you like found on all of our CrowdBoards that people create.
                </div>
                <div class="accHead">
                    3. I am really interested in CrowdFunding but every traditional site I go to just
                    asks me if I have a project to start or do I want to invest in one? I have created
                    some profiles but they are really basic and have very limited networking making
                    it really difficult for me to connect to other people, then also after I join I
                    constantly get lots of emails asking me if I am ready to start now but in truth
                    I am not, as I don’t currently have an idea for a project and also really want to
                    learn a lot more about this before I start really investing, how can you at CrowdBoarders
                    help me with my current dilemma?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    <b>Of course we can</b>, the best part of CrowdBoarders is that it was primarily
                    built <b>to be a Social Network</b>, so we actively encourage everyone firstly to
                    just <b>come and join in</b>! You can firstly build your own <b>in-depth profile showing
                        all the great things about you and what you want to achieve</b>. Then actively
                    search the Network for other CrowdBoarders <b>you would like to connect with</b>
                    or people you already know, send out connection invites and even for <b>some to add
                        them to your very own Boarders Lineup</b>, which displays your top connections
                    on your profile and can be used for the people you most want to associate with in
                    CrowdFunding. You also have <b>your very own Console</b> which displays all the
                    latest information, what new Boards have been created,<b> latest news from all the other
                        CrowdBoarders</b>, we even have a message feature so you can <b>contact anyone directly
                            at any time</b>. We don’t add you to email lists or send you constant requests
                    to start projects, <b>we want you to enjoy the social fun</b>, get to know people,
                    you may later even decide to team up with someone with a similar idea or even invest
                    yourself in something that you feel passionate about, <b>it’s entirely up to you</b>
                    how and when you participate, we just want you to be <b>a part of it now!</b>
                </div>
                <div class="accHead">
                    4. What is a CrowdBoard is that something new or different that you have created?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    <b>Yes</b>, we thought it would be <b>pretty cool</b> to give the Industry <b>its own
                        specific term for raising money online</b>, rather than Projects, Campaigns,
                    Raises, Pitches which can all have lots of different meanings, so we came up with
                    a <b>CrowdBoard</b>, on which you can now display <b>your creative idea for anything</b>
                    to actively seek mass participation and then <b>make it happen</b>.
                </div>
                <div class="accHead">
                    5. How do I create a CrowdBoard for my idea and how can it be easily found by all
                    the other CrowdBoarders in the Network to increase my chances of success?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    Firstly <b>anyone can create</b> a CrowdBoard in <b>only 4 easy steps</b>, actually
                    in one of these steps you personally get to choose the ideal District you want to
                    display it in. We also really believe people’s creative ideas shouldn’t be put into
                    limited categories, hidden away in difficult to find places like everyone else;
                    instead we thought it would be <b>really neat</b> if these great creative ideas
                    were prominently displayed in <b>specific Districts</b> such as Gaming, Design and
                    Films. We currently have <b>20 Districts</b> to choose from and within each District
                    a further <b>10 Areas</b> of specialty to ensure your creative idea gets maximum
                    visibility and an increased chance of success by being really <b>easy to find</b>.
                    Every CrowdBoarder has their <b>own Console</b> which they can save their <b>favorite
                        Districts</b> on and with its unique design they can then <b>quickly locate any new
                            CrowdBoards of interest</b> to them from within their own Network, rather
                    than scrolling through pages and pages as casual visitors like the traditional sites
                    with their low success rates.
                </div>
                <div class="accHead">
                    6. What are the fees to join CrowdBoarders and how much will you charge me if I
                    create a CrowdBoard and then raise funds for my idea?
                </div>
                <div class="acc2">
                    <br />
                    CrowdBoarders is <b>FREE</b> to join, and if you create your own CrowdBoard we charge
                    you <b>ABSOLUTELY NOTHING</b> to raise your funds, we fully believe that there should
                    be <b>no charge whatsoever for creativity</b>, you are looking to make a <b>difference
                        in the World</b> and the CrowdBoarders that believe and invest in your idea
                    will happily pay small fees , the same way that we all buy concert tickets today,
                    the performers don’t pay anything and the participants traditionally pay some type
                    of service fees when purchasing a ticket <b>to be a part of that unique experience</b>.
                </div>
                <div class="accHead">
                    7. How much money can I raise on a CrowdBoard and how will the funding process work
                    in terms of setup, duration, overfunding and receiving funds?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    You can create a CrowdBoard dependent on the type of Board for any amount between
                    the minimum of <b>$100</b> up to the <b>Equity</b> maximum of <b>$1m</b> or without
                    limits for any of the other types. When you create your CrowdBoard you specify the
                    amount required, set the different levels of investments and associated rewards
                    involved in <b>one of the 4 easy steps</b>. Traditional platforms have set durations
                    and encourage overfunding to increase their fees which often leads to slow participation
                    and low success rates, at CrowdBoarders we firmly believe that the <b>Boards success</b>
                    is the most important thing so we don’t set durations instead we promote it as long
                    as possible, and close the Board <b>as soon as it reaches its target funds level</b>
                    after all that is the true purpose, this encourages CrowdBoarders to <b>invest quickly</b>
                    and <b>increases the chances of success</b>, like concert tickets when they are
                    all gone it is too late. If your board is <b>wildly successful</b> and <b>quickly sells
                        out</b> you can even create a <b>“Second Wave” CrowdBoard</b> after to capture
                    more funds for your great idea if needed. CrowdBoarders is also Industry <b>CAPS</b>
                    Accredited to ensure security of information and payments so we utilize <b>WePay</b>
                    as our preferred <b>3rd Party</b> transaction partner, you simply set up an account
                    with them when you create your CrowdBoard so that you can <b>receive your funds directly
                        from WePay</b> once your CrowdBoard has reached its financial target.
                </div>
                <div class="accHead">
                    8. How do I track the progress of my CrowdBoard and provide any updates to my fellow
                    CrowdBoarders that have invested in my idea and provide them their rewards when
                    ready?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    At CrowdBoarders you have a unique function which you can access via your Console
                    called <b>CrowdBoard Command</b> this allows you to quickly view the <b>live status</b>
                    and performance of your Board , it also has a feature <b>Insider News</b> where
                    you <b>can make posts anytime</b> for all of your investors to see with all your
                    <b>latest news</b>, also they can <b>watch it, add comments or ratings</b> so you
                    can always see what they are thinking of your idea, it also displays all of their
                    <b>Insider Details</b> so you can make sure that they can receive the <b>right rewards</b>
                    for their investment when the right time comes.
                </div>
                <div class="accHead">
                    9. How can I best create and promote my CrowdBoard to the public to solicit their
                    investment and also assist me so that I can reach my funds goal as I hear in the
                    region of 60% of all CrowdFunding campaigns in the Industry are currently unsuccessful?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    After you have created your CrowdBoard in 4 easy steps, you have the option to <b>save
                        the draft, send it live</b> or <b>add extras</b>; this is where you can add
                    links, videos and anything you want to make your Board look better and ideally more
                    likely to succeed. As CrowdBoarders is a <b>“Live Network”</b> of people like you
                    there will already be lots of interest in your District for ideas like yours. Also
                    other CrowdBoarders can help you by <b>recommending and boosting your Board</b>
                    within CrowdBoarders so everyone can see that in our latest Crowd News feature.
                    The <b>more CrowdBoarders</b> you get involved the <b>higher the chance of success</b>.
                    You can also always share your idea in other social networks such as Facebook and
                    Twitter, which is the only option you have on traditional platforms and the main
                    reason why so many of their current campaigns are so unsuccessful.
                </div>
                <div class="accHead">
                    10. I am fairly new to CrowdFunding so how can I find help to turn my idea into
                    a CrowdBoard and what if the CrowdBoard I then create doesn’t meet the financial
                    target I initially set?
                </div>
                <div class="acc2">
                    <br />
                    As CrowdBoarders are a <b>“People Driven” company</b> and not a “Process Driven”
                    one. We don’t send you to online guides or schools; instead <b>you can contact us directly
                        anytime</b> and at any stage of turning your idea in a CrowdBoard. One of our
                    own Consultants that <b>specialize in your particular District</b> would be more
                    than happy to make personal contact and <b>talk with you or by email if you prefer</b>
                    and provide you all the advice you need, <b>free of charge naturally</b>. As we
                    also <b>constantly monitor all CrowdBoards</b> so if it does looks likely that your
                    CrowdBoard might not reach the desired target, we can quickly discuss this with
                    you and provide <b>further creative suggestions</b> to help it fund, once any <b>CrowdBoard
                        passes 50% of its set target</b>, the owner will then automatically be eligible
                    to <b>receive all of the total funds raised</b> because after all isn’t that a <b>fair
                        measure of success</b>.
                </div>
                <div class="accHead">
                    11. I have now found a CrowdBoard I would like to invest in, so how does it work?
                    On traditional platforms I have invested in, I have found that I get charged a transaction
                    fee % and after investing I have little to no contact with the owner after that
                    and also have to track all my investments myself how is this going to be different
                    with CrowdBoarders? ?<br />
                </div>
                <div class="acc2">
                    <br />
                    Investing in a CrowdBoard is as simple as viewing the CrowdBoard and <b>clicking the
                        invest button on it</b>, once you have created your WePay account for the first
                    time you can then <b>save it onto your profile for the future.</b> We also have
                    devised a new payment model which is based on <b>services fees,</b> each investment
                    you make there is a <b>set charge of $1 per transaction and $1 per every $10 you invest</b>.
                    So if you decide to invest <b>$25 your total charge would be $28</b>, similarly
                    if you chose <b>$40 your total charge would be $45</b>. These service fees ensure
                    we can <b>maintain the Social Network for everyone</b> and also <b>cover all the % transaction
                        fees charged by WePay</b>. Once you have invested in a CrowdBoard it will <b>automatically
                            be placed onto your Boardfolio</b> a new feature that helps you <b>manage and track
                                all of your investments easily</b>. This is <b>accessed directly from your Console</b>
                    and you can choose to keep each one <b>private or make it public</b> whichever you
                    prefer. Within your Boardfolio you can see Boards you are watching and every investment
                    in detail, <b>access the CrowdBoards Insider News</b> for <b>exclusive updates</b>,
                    live performance, latest comments, current ratings and even make your own notes.
                </div>
                <div class="accHead">
                    12. What happens if a CrowdBoard I invest in doesn’t raise its funding target will
                    I receive a refund? Also can I withdraw my investment in a CrowdBoard at any time
                    after I make it if I decide I want to?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    Naturally if a CrowdBoard fails to fund, <b>your initial investment level will always
                        be fully refunded to you</b> less the service fees that were initially applied,
                    also within your Boardfolio <b>you always have the option to withdraw your funds at
                        any time</b> if you wish until it fully funds, however please bear in mind that
                    as CrowdBoards close when they reach their funding target <b>you may not get the chance
                        again to re-invest</b> into the same Board at a later date if you choose to
                    change your mind on <b>withdrawing your earlier investment</b>.
                </div>
                <div class="accHead">
                    13. Does CrowdBoarders offer equity CrowdBoards if so how does it work?
                    <br />
                </div>
                <div class="acc2">
                    <br />
                    Yes with the recent announcements by the SEC, <b>CrowdBoarders is now able to offer
                        equity opportunities</b>. Businesses offer shares in their company in return
                    for financial investment. When you invest you will be supplied with Terms sheets
                    and after completing these <b>CrowdBoarders will secure the shares on your behalf from
                        the Company you invested in</b>.
                </div>
            </div>
        </div>
        <%-- <div style="margin-top: 30px;">
            <div class="pContent">
                <ol>
                    <li><a href="#one" style="color: #F0F2FD;">Why is CrowdBoarders so different from the
                        traditional Crowdfunding Platforms?</a></li>
                    <li><a href="#two" style="color: #F0F2FD;">Who is a CrowdBoarder and how do I become
                        one?</a></li>
                    <li><a href="#three" style="color: #F0F2FD;">I am really interested in CrowdFunding
                        but every traditional site I go to just asks me if I have a project to start or
                        do I want to invest in one? I have created some profiles but they are really basic
                        and have very limited networking making it really difficult for me to connect to
                        other people, then also after I join I constantly get lots of emails asking me if
                        I am ready to start now but in truth I am not, as I don’t currently have an idea
                        for a project and also really want to learn a lot more about this before I start
                        really investing, how can you at CrowdBoarders help me with my current dilemma?</a></li>
                    <li><a href="#four" style="color: #F0F2FD;">What is a CrowdBoard is that something new
                        or different that you have created?</a></li>
                    <li><a href="#five" style="color: #F0F2FD;">How do I create a CrowdBoard for my idea
                        and how can it be easily found by all the other CrowdBoarders in the Network to
                        increase my chances of success?</a></li>
                    <li><a href="#six" style="color: #F0F2FD;">What are the fees to join CrowdBoarders and
                        how much will you charge me if I create a CrowdBoard and then raise funds for my
                        idea?</a></li>
                    <li><a href="#seven" style="color: #F0F2FD;">How much money can I raise on a CrowdBoard
                        and how will the funding process work in terms of setup, duration, overfunding and
                        receiving funds?</a></li>
                    <li><a href="#eight" style="color: #F0F2FD;">How do I track the progress of my CrowdBoard
                        and provide any updates to my fellow CrowdBoarders that have invested in my idea
                        and provide them their rewards when ready?</a></li>
                    <li><a href="#nine" style="color: #F0F2FD;">How can I best create and promote my CrowdBoard
                        to the public to solicit their investment and also assist me so that I can reach
                        my funds goal as I hear in the region of 60% of all CrowdFunding campaigns in the
                        Industry are currently unsuccessful?</a></li>
                    <li><a href="#ten" style="color: #F0F2FD;">I am fairly new to CrowdFunding so how can
                        I find help to turn my idea into a CrowdBoard and what if the CrowdBoard I then
                        create doesn’t meet the financial target I initially set?</a></li>
                    <li><a href="#eleven" style="color: #F0F2FD;">I have now found a CrowdBoard I would
                        like to invest in, so how does it work? On traditional platforms I have invested
                        in, I have found that I get charged a transaction fee % and after investing I have
                        little to no contact with the owner after that and also have to track all my investments
                        myself how is this going to be different with CrowdBoarders?</a></li>
                    <li><a href="#twelve" style="color: #F0F2FD;">What happens if a CrowdBoard I invest
                        in doesn’t raise its funding target will I receive a refund? Also can I withdraw
                        my investment in a CrowdBoard at any time after I make it if I decide I want to?</a></li>
                    <li><a href="#thirteen" style="color: #F0F2FD;">Does CrowdBoarders offer equity CrowdBoards
                        if so how does it work?</a></li>
                </ol>
            </div>
        </div>
        <div style="margin-top: 20px;">
            <p class="pContent" id="one">
                <span class="spanHeader">Why is CrowdBoarders so different from the traditional Crowdfunding
                    Platforms?</span><br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">CrowdBoarders is the <b>“World’s First Social Investing Network”</b>
                            which was purposely designed and built to create a new <b>Crowdfunding Eco-System</b>,
                            this offers everyone the chance to <b>join, participate, learn, create, invest and connect</b>
                            with likeminded people worldwide using over <b>50 new social features</b> designed
                            specifically for pure enjoyment and most importantly to provide the chance for <b>anyone
                                to make a difference in this world</b> by using the best place possible to showcase
                            their creative ideas and raise the necessary online funds to make them swiftly become
                            a reality.</li></ul>
                </span>
            </p>
            <p class="pContent" id="two">
                <span class="spanHeader">Who is a CrowdBoarder and how do I become one?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">That’s simple <b>Everyone is a CrowdBoarder</b>, all you have to
                            do is <b>create a login</b>, then you are ready to go, once inside CrowdBoarders
                            you are free to enjoy all the <b>social interaction</b> you want and <b>invest in</b>
                            as many exciting opportunities as you like found on all of our CrowdBoards that
                            people create.</li></ul>
                </span>
            </p>
            <p class="pContent" id="three">
                <span class="spanHeader">I am really interested in CrowdFunding but every traditional
                    site I go to just asks me if I have a project to start or do I want to invest in
                    one? I have created some profiles but they are really basic and have very limited
                    networking making it really difficult for me to connect to other people, then also
                    after I join I constantly get lots of emails asking me if I am ready to start now
                    but in truth I am not, as I don’t currently have an idea for a project and also
                    really want to learn a lot more about this before I start really investing, how
                    can you at CrowdBoarders help me with my current dilemma?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent"><b>Of course we can</b>, the best part of CrowdBoarders is that
                            it was primarily built <b>to be a Social Network</b>, so we actively encourage everyone
                            firstly to just <b>come and join in</b>! You can firstly build your own <b>in-depth
                                profile showing all the great things about you and what you want to achieve</b>.
                            Then actively search the Network for other CrowdBoarders <b>you would like to connect
                                with</b> or people you already know, send out connection invites and even for
                            <b>some to add them to your very own Boarders Lineup</b>, which displays your top
                            connections on your profile and can be used for the people you most want to associate
                            with in CrowdFunding. You also have <b>your very own Console</b> which displays
                            all the latest information, what new Boards have been created,<b> latest news from all
                                the other CrowdBoarders</b>, we even have a message feature so you can <b>contact anyone
                                    directly at any time</b>. We don’t add you to email lists or send you constant
                            requests to start projects, <b>we want you to enjoy the social fun</b>, get to know
                            people, you may later even decide to team up with someone with a similar idea or
                            even invest yourself in something that you feel passionate about, <b>it’s entirely up
                                to you</b> how and when you participate, we just want you to be <b>a part of it now!</b></li></ul>
                </span>
            </p>
            <p class="pContent" id="four">
                <span class="spanHeader">What is a CrowdBoard is that something new or different that
                    you have created?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent"><b>Yes</b>, we thought it would be <b>pretty cool</b> to give the
                            Industry <b>its own specific term for raising money online</b>, rather than Projects,
                            Campaigns, Raises, Pitches which can all have lots of different meanings, so we
                            came up with a <b>CrowdBoard</b>, on which you can now display <b>your creative idea
                                for anything</b> to actively seek mass participation and then <b>make it happen</b>.</li></ul>
                </span>
            </p>
            <p class="pContent" id="five">
                <span class="spanHeader">How do I create a CrowdBoard for my idea and how can it be
                    easily found by all the other CrowdBoarders in the Network to increase my chances
                    of success?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">Firstly <b>anyone can create</b> a CrowdBoard in <b>only 4 easy
                            steps</b>, actually in one of these steps you personally get to choose the ideal
                            District you want to display it in. We also really believe people’s creative ideas
                            shouldn’t be put into limited categories, hidden away in difficult to find places
                            like everyone else; instead we thought it would be <b>really neat</b> if these great
                            creative ideas were prominently displayed in <b>specific Districts</b> such as Gaming,
                            Design and Films. We currently have <b>20 Districts</b> to choose from and within
                            each District a further <b>10 Areas</b> of specialty to ensure your creative idea
                            gets maximum visibility and an increased chance of success by being really <b>easy to
                                find</b>. Every CrowdBoarder has their <b>own Console</b> which they can save
                            their <b>favorite Districts</b> on and with its unique design they can then <b>quickly
                                locate any new CrowdBoards of interest</b> to them from within their own Network,
                            rather than scrolling through pages and pages as casual visitors like the traditional
                            sites with their low success rates.</li></ul>
                </span>
            </p>
            <p class="pContent" id="six">
                <span class="spanHeader">What are the fees to join CrowdBoarders and how much will you
                    charge me if I create a CrowdBoard and then raise funds for my idea?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">CrowdBoarders is <b>FREE</b> to join, and if you create your own
                            CrowdBoard we charge you <b>ABSOLUTELY NOTHING</b> to raise your funds, we fully
                            believe that there should be <b>no charge whatsoever for creativity</b>, you are
                            looking to make a <b>difference in the World</b> and the CrowdBoarders that believe
                            and invest in your idea will happily pay small fees , the same way that we all buy
                            concert tickets today, the performers don’t pay anything and the participants traditionally
                            pay some type of service fees when purchasing a ticket <b>to be a part of that unique
                                experience</b>.</li></ul>
                </span>
            </p>
            <p class="pContent" id="seven">
                <span class="spanHeader">How much money can I raise on a CrowdBoard and how will the
                    funding process work in terms of setup, duration, overfunding and receiving funds?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">You can create a CrowdBoard dependent on the type of Board for
                            any amount between the minimum of <b>$100</b> up to the <b>Equity</b> maximum of
                            <b>$1m</b> or without limits for any of the other types. When you create your CrowdBoard
                            you specify the amount required, set the different levels of investments and associated
                            rewards involved in <b>one of the 4 easy steps</b>. Traditional platforms have set
                            durations and encourage overfunding to increase their fees which often leads to
                            slow participation and low success rates, at CrowdBoarders we firmly believe that
                            the <b>Boards success</b> is the most important thing so we don’t set durations
                            instead we promote it as long as possible, and close the Board <b>as soon as it reaches
                                its target funds level</b> after all that is the true purpose, this encourages
                            CrowdBoarders to <b>invest quickly</b> and <b>increases the chances of success</b>,
                            like concert tickets when they are all gone it is too late. If your board is <b>wildly
                                successful</b> and <b>quickly sells out</b> you can even create a <b>“Second Wave” CrowdBoard</b>
                            after to capture more funds for your great idea if needed. CrowdBoarders is also
                            Industry <b>CAPS</b> Accredited to ensure security of information and payments so
                            we utilize <b>WePay</b> as our preferred <b>3rd Party</b> transaction partner, you
                            simply set up an account with them when you create your CrowdBoard so that you can
                            <b>receive your funds directly from WePay</b> once your CrowdBoard has reached its
                            financial target.</li></ul>
                </span>
            </p>
            <p class="pContent" id="eight">
                <span class="spanHeader">How do I track the progress of my CrowdBoard and provide any
                    updates to my fellow CrowdBoarders that have invested in my idea and provide them
                    their rewards when ready?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">At CrowdBoarders you have a unique function which you can access
                            via your Console called <b>CrowdBoard Command</b> this allows you to quickly view
                            the <b>live status</b> and performance of your Board , it also has a feature <b>Insider
                                News</b> where you <b>can make posts anytime</b> for all of your investors to
                            see with all your <b>latest news</b>, also they can <b>watch it, add comments or ratings</b>
                            so you can always see what they are thinking of your idea, it also displays all
                            of their <b>Insider Details</b> so you can make sure that they can receive the <b>right
                                rewards</b> for their investment when the right time comes.</li></ul>
                </span>
            </p>
            <p class="pContent" id="nine">
                <span class="spanHeader">How can I best create and promote my CrowdBoard to the public
                    to solicit their investment and also assist me so that I can reach my funds goal
                    as I hear in the region of 60% of all CrowdFunding campaigns in the Industry are
                    currently unsuccessful?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">After you have created your CrowdBoard in 4 easy steps, you have
                            the option to <b>save the draft, send it live</b> or <b>add extras</b>; this is
                            where you can add links, videos and anything you want to make your Board look better
                            and ideally more likely to succeed. As CrowdBoarders is a <b>“Live Network”</b>
                            of people like you there will already be lots of interest in your District for ideas
                            like yours. Also other CrowdBoarders can help you by <b>recommending and boosting your
                                Board</b> within CrowdBoarders so everyone can see that in our latest Crowd
                            News feature. The <b>more CrowdBoarders</b> you get involved the <b>higher the chance
                                of success</b>. You can also always share your idea in other social networks
                            such as Facebook and Twitter, which is the only option you have on traditional platforms
                            and the main reason why so many of their current campaigns are so unsuccessful.
                        </li>
                    </ul>
                </span>
            </p>
            <p class="pContent" id="ten">
                <span class="spanHeader">I am fairly new to CrowdFunding so how can I find help to turn
                    my idea into a CrowdBoard and what if the CrowdBoard I then create doesn’t meet
                    the financial target I initially set?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">As CrowdBoarders are a <b>“People Driven” company</b> and not a
                            “Process Driven” one. We don’t send you to online guides or schools; instead <b>you
                                can contact us directly anytime</b> and at any stage of turning your idea in
                            a CrowdBoard. One of our own Consultants that <b>specialize in your particular District</b>
                            would be more than happy to make personal contact and <b>talk with you or by email if
                                you prefer</b> and provide you all the advice you need, <b>free of charge naturally</b>.
                            As we also <b>constantly monitor all CrowdBoards</b> so if it does looks likely
                            that your CrowdBoard might not reach the desired target, we can quickly discuss
                            this with you and provide <b>further creative suggestions</b> to help it fund, once
                            any <b>CrowdBoard passes 50% of its set target</b>, the owner will then automatically
                            be eligible to <b>receive all of the total funds raised</b> because after all isn’t
                            that a <b>fair measure of success</b>. </li>
                    </ul>
                </span>
            </p>
            <p class="pContent" id="eleven">
                <span class="spanHeader">I have now found a CrowdBoard I would like to invest in, so
                    how does it work? On traditional platforms I have invested in, I have found that
                    I get charged a transaction fee % and after investing I have little to no contact
                    with the owner after that and also have to track all my investments myself how is
                    this going to be different with CrowdBoarders?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">Investing in a CrowdBoard is as simple as viewing the CrowdBoard
                            and <b>clicking the invest button on it</b>, once you have created your WePay account
                            for the first time you can then <b>save it onto your profile for the future.</b>
                            We also have devised a new payment model which is based on <b>services fees,</b>
                            each investment you make there is a <b>set charge of $1 per transaction and $1 per every
                                $10 you invest</b>. So if you decide to invest <b>$25 your total charge would be $28</b>,
                            similarly if you chose <b>$40 your total charge would be $45</b>. These service
                            fees ensure we can <b>maintain the Social Network for everyone</b> and also <b>cover
                                all the % transaction fees charged by WePay</b>. Once you have invested in a
                            CrowdBoard it will <b>automatically be placed onto your Boardfolio</b> a new feature
                            that helps you <b>manage and track all of your investments easily</b>. This is <b>accessed
                                directly from your Console</b> and you can choose to keep each one <b>private or make
                                    it public</b> whichever you prefer. Within your Boardfolio you can see Boards
                            you are watching and every investment in detail, <b>access the CrowdBoards Insider News</b>
                            for <b>exclusive updates</b>, live performance, latest comments, current ratings
                            and even make your own notes.</li>
                    </ul>
                </span>
            </p>
            <p class="pContent" id="twelve">
                <span class="spanHeader">What happens if a CrowdBoard I invest in doesn’t raise its
                    funding target will I receive a refund? Also can I withdraw my investment in a CrowdBoard
                    at any time after I make it if I decide I want to?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">Naturally if a CrowdBoard fails to fund, <b>your initial investment
                            level will always be fully refunded to you</b> less the service fees that were initially
                            applied, also within your Boardfolio <b>you always have the option to withdraw your
                                funds at any time</b> if you wish until it fully funds, however please bear
                            in mind that as CrowdBoards close when they reach their funding target <b>you may not
                                get the chance again to re-invest</b> into the same Board at a later date if
                            you choose to change your mind on <b>withdrawing your earlier investment</b>.</li>
                    </ul>
                </span>
            </p>
            <p class="pContent" id="thirteen">
                <span class="spanHeader">Does CrowdBoarders offer equity CrowdBoards if so how does
                    it work?</span>
                <br />
                <span class="spanMargin">
                    <ul>
                        <li class="pContent">Yes with the recent announcements by the SEC, <b>CrowdBoarders
                            is now able to offer equity opportunities</b>. Businesses offer shares in their
                            company in return for financial investment. When you invest you will be supplied
                            with Terms sheets and after completing these <b>CrowdBoarders will secure the shares
                                on your behalf from the Company you invested in</b>.</li>
                    </ul>
                </span>
            </p>
        </div>--%>
    </div>
    <!--        Right Column      -->
    <div class="right-column fixedElement">
        <h4>
            More Info</h4>
        <div class="blue-link">
            <a href="MoreInfo/howitworks.html">How it Works</a></div>
        <div class="blue-link">
            <a href="MoreInfo/youareacrowdboarder.html">You are a CrowdBoarder</a></div>
        <div class="blue-link">
            <a href="MoreInfo/crowdfundinggoessocial.html">Crowdfunding goes Social</a></div>
        <div class="blue-link">
            <a href="MoreInfo/industrycomparison.html">Industry Comparison</a></div>
        <div class="blue-link">
            <a href="MoreInfo/howdoesyourprofilelook.html">How does your profile look? </a>
        </div>
        <div class="blue-link">
            <a href="MoreInfo/quotes.html">CrowdBoarder Quotes </a>
        </div>
    </div>
    
</asp:Content>
