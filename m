From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Date: Wed, 15 Jan 2020 12:21:33 -0800
Subject: [PATCH] clk: ast2600: enable BCLK for PCI/PCIe bus always
In-Reply-To: <CACPK8XfevBQxdAanN5QjiUv8KKevetjKP7cbr3tuL=mrULjttg@mail.gmail.com>
References: <20200113213453.27108-1-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xf0Oa62BsNOQ55rqAp_a=V-_9bm1c4nu_+Oo5zB=2+zpA@mail.gmail.com>
 <255b53d2-d4b5-8bc0-393b-a2f531a98fc1@linux.intel.com>
 <CACPK8XfevBQxdAanN5QjiUv8KKevetjKP7cbr3tuL=mrULjttg@mail.gmail.com>
Message-ID: <794bcd23-185a-08c1-cdb1-9d7ca65bcb1e@linux.intel.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 1/14/2020 9:43 PM, Joel Stanley wrote:
> On Tue, 14 Jan 2020 at 19:53, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>
>> Hi Joel,
>>
>> On 1/13/2020 10:15 PM, Joel Stanley wrote:
>>> On Mon, 13 Jan 2020 at 21:33, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>>>>
>>>> BCLK for PCI/PCIe bus should be enabled always with having the
>>>> CLK_IS_CRITICAL flag otherwise it will be disabled at kernel late
>>>> initcall phase as an unused clock, and eventually it causes
>>>> unexpected behavior on BMC features that are connected to the host
>>>> through PCI/PCIe bus.
>>>
>>> This is true for systems that have PCIe connected. There are systems
>>> that do not, and in that case we don't want to have the clock enabled.
>>>
>>> Are you doing this to support the case where the PCIe device not load
>>> a BMC driver? (eg for host VGA use). If not, then you can have the
>>> driver you're loading request the BCLK.
>>>
>>> If this is for the host VGA device, then you will need to come up with
>>> a mechanism that makes the enabling of this clock depend on the device
>>> tree.
>>
>> Is there any way to enable clock by just adding a node in device tree?
>> Do you want me to add a simple driver module for host VGA just for
>> enabling BCLK?
> 
> Okay, so this is for the case where we lack a BMC driver.
> 
> One option would be to do as you suggest, adding a simple driver that
> claims essential clocks.
> 
> Another could be to add some extra properties that clock driver parses
> and enables the clocks.
> 

Looks like it needs changes in clk-ast2600 module for checking of
'clock-critical' device tree property. Let me try to make it.

Thanks,
Jae
