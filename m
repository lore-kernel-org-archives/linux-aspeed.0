From: Quan Nguyen <quan@os.amperecomputing.com>
Date: Wed, 21 Sep 2022 14:57:27 +0700
Subject: [PATCH v3 2/2] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Mitchell BMC
In-Reply-To: <b34ab4d0-c14f-caeb-afde-01655b35a236@os.amperecomputing.com>
References: <20220817071539.176110-1-quan@os.amperecomputing.com>
 <20220817071539.176110-3-quan@os.amperecomputing.com>
 <CACPK8XdDpG3ONM1=-E6qvHL1FgMNWSMPoL_sVGJK6BmmnT3w_w@mail.gmail.com>
 <CAK8P3a2LZKfZpdTQ-R4o9mJ6dk52VRF+Bxj=PJEx-1MA4yH8+w@mail.gmail.com>
 <673e200f-f458-7866-f956-3d5bd7160a49@os.amperecomputing.com>
 <CAK8P3a3MU7shuBpcpRNC5L6xxQmSy8FXCX1jvYXhv-NT3PMYOw@mail.gmail.com>
 <396a3c24-2a86-0d1c-07f9-386a0de1d473@os.amperecomputing.com>
 <b34ab4d0-c14f-caeb-afde-01655b35a236@os.amperecomputing.com>
Message-ID: <60188017-8f96-0773-7eaf-43d877f876b2@os.amperecomputing.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Arnd,

I'm really sorry but I have to ping you again as I'm confused and still 
wonder if anything else could be updated to this patchset. Could you 
share some suggestion on what to do next ? or should I resend it?

The only thing left is Joel's complaint about there is no output to test 
with bootargs removed. I have tried and see it could be fixed by using 
the -append option with qemu.

Besides, Joel also says it "looks ready to merge" and give a Reviewed-by 
already.

Thank you and best regards,
- Quan


On 13/09/2022 14:42, Quan Nguyen wrote:
> Hi,
> 
> Just a gentle ping on the patch.
> 
> Thanks and best regards,
> - Quan
> 
> On 05/09/2022 16:45, Quan Nguyen wrote:
>>
>>
>> On 25/08/2022 19:35, Arnd Bergmann wrote:
>>> On Tue, Aug 23, 2022 at 10:27 AM Quan Nguyen
>>> <quan@os.amperecomputing.com> wrote:
>>>> On 18/08/2022 19:06, Arnd Bergmann wrote:
>>>>
>>>> Thanks Arnd for the comment.
>>>>
>>>> I think adding -append could solve the issue.
>>>>
>>>> But as the bootargs still exist in all other
>>>> arch/arm/boot/dts/aspeed-bmc-*.dts should we still keep bootargs for
>>>> this dts?
>>>
>>> I think it should still be removed. Only 238 of 2547 set the console 
>>> using
>>> bootargs, so that would make it more consistent with the other files.
>>>
>>> Changing the files that have the same issue is a separate matter.
>>>
>>
>> Hi Joel,
>>
>> In the meantime, I'm just wonder if you could help to test the patch 
>> with -append and get it merged.
>>
>> Thank you and best regards,
>> - Quan
