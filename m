From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Tue, 11 Dec 2018 17:45:02 +0100
Subject: [PATCH v7 2/2] media: platform: Add Aspeed Video Engine driver
In-Reply-To: <08ffe734-7c08-370e-0a10-09f3924f24c0@linux.vnet.ibm.com>
References: <1544480791-92746-1-git-send-email-eajames@linux.ibm.com>
 <1544480791-92746-3-git-send-email-eajames@linux.ibm.com>
 <6567e0a4-ad58-1340-199e-e5d5b267f3ac@xs4all.nl>
 <08ffe734-7c08-370e-0a10-09f3924f24c0@linux.vnet.ibm.com>
Message-ID: <828d274c-8a0f-d90f-d383-178360f9ac30@xs4all.nl>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/11/18 5:41 PM, Eddie James wrote:

<snip>

>> Running checkpatch.pl --strict over the patch gives me three 'CHECK' items
>> they you should also address:
>>
>> CHECK: struct mutex definition without comment
>> #312: FILE: drivers/media/platform/aspeed-video.c:222:
>> +?????? struct mutex video_lock;
>>
>> CHECK: spinlock_t definition without comment
>> #315: FILE: drivers/media/platform/aspeed-video.c:225:
>> +?????? spinlock_t lock;
>>
>> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.txt
>> #580: FILE: drivers/media/platform/aspeed-video.c:490:
>> +?????? udelay(100);
> 
> This one has to be udelay due to possibly being called in the interrupt handler...

Please add a comment for that.

> 
>>
>> I think v8 can be the final version. It probably won't make 4.21, though.
>> If I'll get a v8 today, then there is a small chance it might still make it.
>> If not, then it'll be merged early in the 4.22 cycle.
> 
> OK, no worries either way. Will send v8 in a few.

Looking forward to that.

Regards,

	Hans

> 
> Thanks for all the review!
> Eddie
> 
>>
>> Regards,
>>
>> ????Hans
>>
> 

