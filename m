From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 26 Jan 2022 09:41:27 +0800
Subject: [PATCH v4 0/2] Fix incorrect resolution detected
In-Reply-To: <c3202b1f-ff8f-8108-e8a3-8710c8c74d10@xs4all.nl>
References: <20220118100729.7651-1-jammy_huang@aspeedtech.com>
 <c3202b1f-ff8f-8108-e8a3-8710c8c74d10@xs4all.nl>
Message-ID: <8681fe29-69c2-f701-aff4-c27cef2d32d7@aspeedtech.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2022/1/25 ?? 06:43, Hans Verkuil wrote:
> Hi Jammy,
>
> On 18/01/2022 11:07, Jammy Huang wrote:
>> This series fixes incorrect resolution detected.
>> We found this problem happened occasionally in the switch between bios
>> and bootloader.
> Can you rebase this on top of:
>
> https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v5.18f
>
> This series doesn't apply cleanly.

OK, I will update patch based on this code base.

Regards,

	Jammy

>
> Regards,
>
> 	Hans
>
>> Changes in v4:
>>   - Correct the subject of patch
>>
>> Changes in v3:
>>   - In v2, we tried to increase the min-required-count of stable signal
>>     to avoid incorrect transient state in timing detection. But it is
>>     not working for all conditions.
>>     Thus, we go another way in v3. Use regs, which can represent the
>>     signal status, to decide if we needs to do detection again.
>>   
>> Changes in v2:
>>   - Separate the patch into two patches
>>
>> Jammy Huang (2):
>>    media: aspeed: Add macro for the fields of the mode-detect registers
>>    media: aspeed: Fix unstable timing detection
>>
>>   drivers/media/platform/aspeed-video.c | 25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)
>>
-- 
Best Regards
Jammy

