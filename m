From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 12 Jan 2022 14:05:41 +0800
Subject: [PATCH] media: aspeed: Fix no complete irq for non-64-aligned
 width
In-Reply-To: <CACPK8XfkXi6M=gzfkYcuoga6WxnzSm2+mspBt4gjop7Ytm+VCA@mail.gmail.com>
References: <20211214045348.13702-1-jammy_huang@aspeedtech.com>
 <CACPK8XfkXi6M=gzfkYcuoga6WxnzSm2+mspBt4gjop7Ytm+VCA@mail.gmail.com>
Message-ID: <a779f1c1-e5b0-5d55-bc6c-5f253d03525d@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

OK, thanks for your review. I will send another updated patch per your 
advice.

On 2022/1/12 ?? 08:51, Joel Stanley wrote:
> On Tue, 14 Dec 2021 at 04:53, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>> In ast2500, engine will stop occasionally for 1360x768.
>>
>> This is a bug which has been addressed, but the workaround is specific
>> for 1680 only. Here we make it more complete.
>>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 793b2adaa0f5..4d3e6b105d44 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -1055,18 +1055,20 @@ static void aspeed_video_set_resolution(struct aspeed_video *video)
>>          /* Set capture/compression frame sizes */
>>          aspeed_video_calc_compressed_size(video, size);
>>
>> -       if (video->active_timings.width == 1680) {
>> +       if (!IS_ALIGNED(act->width, 64)) {
>>                  /*
>>                   * This is a workaround to fix a silicon bug on A1 and A2
> Please add:  "a AST2500 silicon bug" so we know which A1/A2 this is
> referring to.
>
> With that added, you can add:
>
>   Reviewed-by: Joel Stanley <joel@jms.id.au>
>
>>                   * revisions. Since it doesn't break capturing operation of
>>                   * other revisions, use it for all revisions without checking
>> -                * the revision ID. It picked 1728 which is a very next
>> -                * 64-pixels aligned value to 1680 to minimize memory bandwidth
>> +                * the revision ID. It picked new width which is a very next
>> +                * 64-pixels aligned value to minimize memory bandwidth
>>                   * and to get better access speed from video engine.
>>                   */
>> +               u32 width = ALIGN(act->width, 64);
>> +
>>                  aspeed_video_write(video, VE_CAP_WINDOW,
>> -                                  1728 << 16 | act->height);
>> -               size += (1728 - 1680) * video->active_timings.height;
>> +                                  width << 16 | act->height);
>> +               size = width * act->height;
> You could make it clearer by putting the write on one line:
>
>                  aspeed_video_write(video, VE_CAP_WINDOW, width << 16 |
> act->height);

-- 
Best Regards
Jammy

