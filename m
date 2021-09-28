From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 28 Sep 2021 11:57:03 -0700
Subject: [PATCH v3] media: aspeed-video: ignore interrupts that aren't
 enabled
In-Reply-To: <CACPK8XfE6zB9BWYq7e8WbXkPFp2Cicwv2x2dc8h6jNaR2qZV0g@mail.gmail.com>
References: <20210617220229.7352-1-zev@bewilderbeest.net>
 <46edf81d60a38747f7d2511f840253a1c6867652.camel@linux.ibm.com>
 <HK0PR06MB338081E134AA6F43ECBCBA4DF2D29@HK0PR06MB3380.apcprd06.prod.outlook.com>
 <CACPK8XfE6zB9BWYq7e8WbXkPFp2Cicwv2x2dc8h6jNaR2qZV0g@mail.gmail.com>
Message-ID: <YVNlfwLUDNxtp0fs@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 06, 2021 at 04:47:14AM PDT, Joel Stanley wrote:
>Hi Mauro,
>
>On Mon, 6 Sept 2021 at 10:10, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>> > Subject: Re: [PATCH v3] media: aspeed-video: ignore interrupts that aren't
>> > enabled
>> >
>> > On Thu, 2021-06-17 at 17:02 -0500, Zev Weiss wrote:
>> > > As partially addressed in commit 65d270acb2d6 ("media: aspeed: clear
>> > > garbage interrupts"), the ASpeed video engine sometimes asserts
>> > > interrupts that the driver hasn't enabled.  In addition to the
>> > > CAPTURE_COMPLETE and FRAME_COMPLETE interrupts dealt with in that
>> > > patch, COMP_READY has also been observed.  Instead of playing
>> > > whack-a-mole with each one individually, we can instead just blanket
>> > > ignore everything we haven't explicitly enabled.
>> >
>> > Suspect this will fix an intermittent problem on AST2500 with screensaver.
>> > Change looks good, thanks!
>> >
>> > Reviewed-by: Eddie James <eajames@linux.ibm.com>
>> >
>> Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
>> > >
>> > > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>
>I notice this wasn't merged in the pull request you sent for v5.15.
>Would you be able to ensure it makes it in the next pull request you
>send?
>
>It can have some fixes tags too:
>
>Fixes: 65d270acb2d6 ("media: aspeed: clear garbage interrupts")
>Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
>Acked-by: Joel Stanley <joel@jms.id.au>
>
>Cheers,
>
>Joel
>

Also not in the recent merge of the media/v5.15-2 tag it looks like -- ping?


Thanks,
Zev

