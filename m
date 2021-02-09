From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Tue, 9 Feb 2021 11:17:29 -0800
Subject: [PATCH v2 1/4] dt-bindings: i2c: aspeed: add buffer and DMA mode
 transfer support
In-Reply-To: <CACPK8XekihpoXEeyUbWSXsRkVMbX1gKG-gSeYgWq=s3UR2gi1g@mail.gmail.com>
References: <20210112003749.10565-1-jae.hyun.yoo@linux.intel.com>
 <20210112003749.10565-2-jae.hyun.yoo@linux.intel.com>
 <20210114193416.GA3432711@robh.at.kernel.org>
 <4f67358e-58e5-65a5-3680-1cd8e9851faa@linux.intel.com>
 <CACPK8XcZTE=bnCP1-E9PTA09WnXG9Eduwx0dm-QqmQJUDa_OrQ@mail.gmail.com>
 <1814b8d1-954c-0988-0745-e95129079708@linux.intel.com>
 <87ed4085-26e4-98f8-21e3-b1e3c16b0891@linux.intel.com>
 <CACPK8XekihpoXEeyUbWSXsRkVMbX1gKG-gSeYgWq=s3UR2gi1g@mail.gmail.com>
Message-ID: <3cb75f5e-43d8-a06c-5149-e69823728325@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/9/2021 4:10 AM, Joel Stanley wrote:
> On Wed, 3 Feb 2021 at 23:03, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Hi Joel
>>
>> On 1/28/2021 11:36 AM, Jae Hyun Yoo wrote:
>>> Hi Joel
>>>
>>> On 1/27/2021 4:06 PM, Joel Stanley wrote:
>>>>>> All this information doesn't need to be in the binding.
>>>>>>
>>>>>> It's also an oddly structured dts file if this is what you are doing...
>>>>>
>>>>> I removed the default buffer mode settings that I added into
>>>>> 'aspeed-g4.dtsi' and 'aspeed-g5.dtsi' in v1 to avoid touching of the
>>>>> default transfer mode setting, but each bus should use its dedicated
>>>>> SRAM buffer range for enabling buffer mode so I added this information
>>>>> at here as overriding examples instead. I thought that binding document
>>>>> is a right place for providing this information but looks like it's not.
>>>>> Any recommended place for it? Is it good enough if I add it just into
>>>>> the commit message?
>>>>
>>>> I agree with Rob, we don't need this described in the device tree
>>>> (binding or dts). We know what the layout is for a given aspeed
>>>> family, so the driver can have this information hard coded.
>>>>
>>>> (Correct me if I've misinterpted here Rob)
>>>>
>>>
>>> Makes sense. Will add these settings into the driver module as hard
>>> coded per each bus.
>>>
>>
>> Realized that the SRAM buffer range setting should be added into device
>> tree because each bus module should get the dedicated IO resource range.
>> So I'm going to add it to dtsi default reg setting for each I2C bus
>> and will remove this description in binding. Also, I'll add a mode
>> setting property instead to keep the current setting as byte mode.
> 
> I don't understand. What do you propose adding?
> 

I'm going to add reg resource for the SRAM buffer per each bus like

reg = <0x40 0x40>, <0x800 0x80>;

into the aspeed-g*.dtsi but adding like this will not be a key for
enabling buffer mode like this v2 does. Also, I'm going to remove the
'aspeed,dma-buf-size' in this patch series and I'll add fixed DMA length
as a configuration per each SoC. Instead, I'm going to add a xfer mode
property e.g. 'aspeed,i2c-xfer-mode' to select 'byte', 'buffer' or 'dma'
modes.

Thanks,
Jae
