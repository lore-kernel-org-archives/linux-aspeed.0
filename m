From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 10 Nov 2021 11:33:02 +0800
Subject: [PATCH] media: aspeed: Fix incorrect resolution detected
In-Reply-To: <ac30786b-dbeb-db77-4fd8-6fe1efbdb929@molgen.mpg.de>
References: <20211109095453.12363-1-jammy_huang@aspeedtech.com>
 <ac30786b-dbeb-db77-4fd8-6fe1efbdb929@molgen.mpg.de>
Message-ID: <e8b51641-7b5f-376c-92e1-3d52d0f98f46@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Paul,

On 2021/11/9 ?? 07:22, Paul Menzel wrote:
> Dear Jammy,
>
>
> Am 09.11.21 um 10:54 schrieb Jammy Huang:
>> During the process of os-installation, detected resolution's height
>> could be less than the correct one.
> Can you please elaborate? What OS? What resolution was and what
> resolution should have been detected?
My bad. This is the scenario our QA used to find this problem, but it 
could happen in
any scenario with successive timing-change condition. I will update to 
have a more
elaborate message
>
>> Increase min-required-count of stable signal to fix the problem.
> So you do two changes in the patch? First use the bitfield access
> macros, and then change VE_MODE_DT_HOR_STABLE and VE_MODE_DT_VER_STABLE
> from 6 to 10? Is that the amount of iterations? Why 10 and not 20?
> How much time do four iterations add?
VE_MODE_DT_HOR_STABLE means the min required count in detecting stable
HSYNC signal to set mode detection horizontal signal stable.
VE_MODE_DT_VER_STABLE means the min required count in detecting stable
VSYNC signal to set mode detection vertical signal stable.

How much time these iterations take varies by the input timing.
If VE_MODE_DT_VER_STABLE is 10, it means 10 successive stable vsync required
to make vertical signal stable flag raised. If the current timing is 60 
fps, it will takes
at least 10/60 second.
The suggested min acceptable value for these two are 3 and max is 15.
> Sorry for my ignorance, but if you could make it two patches, that?d be
> great.
Sure, I will make it two patches in next update.
>
>> Fixes: d2b4387f3bdf ("media: platform: Add Aspeed Video Engine driver")
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>    drivers/media/platform/aspeed-video.c | 13 ++++++++++++-
>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index 5da52646b298..625a77ddb479 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -196,6 +196,12 @@
>>    #define  VE_INTERRUPT_VSYNC_DESC	BIT(11)
>>    
>>    #define VE_MODE_DETECT			0x30c
>> +#define  VE_MODE_DT_HOR_TOLER		GENMASK(31, 28)
>> +#define  VE_MODE_DT_VER_TOLER		GENMASK(27, 24)
>> +#define  VE_MODE_DT_HOR_STABLE		GENMASK(23, 20)
>> +#define  VE_MODE_DT_VER_STABLE		GENMASK(19, 16)
>> +#define  VE_MODE_DT_EDG_THROD		GENMASK(15, 8)
>> +
>>    #define VE_MEM_RESTRICT_START		0x310
>>    #define VE_MEM_RESTRICT_END		0x314
>>    
>> @@ -1199,7 +1205,12 @@ static void aspeed_video_init_regs(struct aspeed_video *video)
>>    	aspeed_video_write(video, VE_SCALING_FILTER3, 0x00200000);
>>    
>>    	/* Set mode detection defaults */
>> -	aspeed_video_write(video, VE_MODE_DETECT, 0x22666500);
>> +	aspeed_video_write(video, VE_MODE_DETECT,
>> +			   FIELD_PREP(VE_MODE_DT_HOR_TOLER, 2) |
>> +			   FIELD_PREP(VE_MODE_DT_VER_TOLER, 2) |
>> +			   FIELD_PREP(VE_MODE_DT_HOR_STABLE, 10) |
>> +			   FIELD_PREP(VE_MODE_DT_VER_STABLE, 10) |
>> +			   FIELD_PREP(VE_MODE_DT_EDG_THROD, 0x65));
>>    
>>    	aspeed_video_write(video, VE_BCD_CTRL, 0);
>>    }
>>
>
> Kind regards,
>
> Paul

-- 
Best Regards
Jammy

