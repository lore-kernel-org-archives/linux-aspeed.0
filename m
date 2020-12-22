From: Zev Weiss <zev@bewilderbeest.net>
Date: Tue, 22 Dec 2020 13:11:26 -0600
Subject: [PATCH 1/3] aspeed-video: add error message for unhandled
 interrupts
In-Reply-To: <CACPK8XfPCjBbjM2V1oiD=di6MD6ewJs0NFewA0=kZfx_eL29gQ@mail.gmail.com>
References: <20201215024542.18888-1-zev@bewilderbeest.net>
 <20201215024542.18888-2-zev@bewilderbeest.net>
 <CACPK8XfPCjBbjM2V1oiD=di6MD6ewJs0NFewA0=kZfx_eL29gQ@mail.gmail.com>
Message-ID: <20201222191126.uh3psmc4l74dulwb@hatter.bewilderbeest.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Dec 21, 2020 at 10:34:26PM CST, Joel Stanley wrote:
>On Tue, 15 Dec 2020 at 02:46, Zev Weiss <zev@bewilderbeest.net> wrote:
>>
>> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>> ---
>>  drivers/media/platform/aspeed-video.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 7d98db1d9b52..eb02043532e3 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -562,6 +562,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>>  {
>>         struct aspeed_video *video = arg;
>>         u32 sts = aspeed_video_read(video, VE_INTERRUPT_STATUS);
>> +       u32 orig_sts = sts;
>>
>>         /*
>>          * Resolution changed or signal was lost; reset the engine and
>> @@ -639,6 +640,10 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>>         if (sts & VE_INTERRUPT_FRAME_COMPLETE)
>>                 sts &= ~VE_INTERRUPT_FRAME_COMPLETE;
>>
>> +       if (sts)
>> +               dev_err_ratelimited(video->dev, "unexpected interrupt asserted:"
>> +                                   " sts=%08x, orig_sts=%08x", sts, orig_sts);
>
>Do you want to do this before clearing the FRAME and CAPTURE bits?
>

My intent was to only issue the message for unexpectedly-asserted 
interrupts that aren't among the ones already known to happen despite 
being disabled -- basically just indicating that a new bit might need to 
be added to the spurious-interrupt mask added in the second patch.  (I 
included the orig_sts element in case there's any useful debugging 
information to be gleaned from what other interrupts got asserted along 
with it, which would also include FRAME, CAPTURE, and any others 
explicitly cleared.)

And incidentally, in the handful of instances I captured in which this 
problem arose, it seemed to be "sticky" in that it continued occurring 
on every frame until the device was reset, so it seems like it would be 
likely to lead to a fair amount of log spam for a condition where it's 
basically just "we're ignoring known misbehavior" and there's not much 
else to do about it.


Zev

