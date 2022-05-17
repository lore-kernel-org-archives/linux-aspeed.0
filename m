From: Cédric Le Goater <clg@kaod.org>
Date: Tue, 17 May 2022 15:41:04 +0200
Subject: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC driver
 to spi-mem
In-Reply-To: <20220517143713.47676b4c@xps-13>
References: <20220509175616.1089346-1-clg@kaod.org>
 <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
 <20220517110509.2e6xbwot63yl6a3c@ti.com>
 <a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org>
 <20220517143713.47676b4c@xps-13>
Message-ID: <ad7650a2-883b-3c1d-8628-353ae3528848@kaod.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Miquel,

On 5/17/22 14:37, Miquel Raynal wrote:
> Hi C?dric,
> 
> clg at kaod.org wrote on Tue, 17 May 2022 14:03:02 +0200:
> 
>> Pratyush,
>>
>> On 5/17/22 13:05, Pratyush Yadav wrote:
>>> Hi Cedric,
>>>
>>> On 16/05/22 07:39PM, Mark Brown wrote:
>>>> On Mon, 9 May 2022 19:56:05 +0200, C?dric Le Goater wrote:
>>>>> This series adds a new SPI driver using the spi-mem interface for the
>>>>> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
>>>>> SoCs.
>>>>>
>>>>>    * AST2600 Firmware SPI Memory Controller (FMC)
>>>>>    * AST2600 SPI Flash Controller (SPI1 and SPI2)
>>>>>    * AST2500 Firmware SPI Memory Controller (FMC)
>>>>>    * AST2500 SPI Flash Controller (SPI1 and SPI2)
>>>>>    * AST2400 New Static Memory Controller (also referred as FMC)
>>>>>    * AST2400 SPI Flash Controller (SPI)
>>>>>
>>>>> [...]
>>>>
>>>> Applied to
>>>>
>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>>>>
>>>> Thanks!
>>>>
>>>> [02/11] dt-bindings: spi: Convert the Aspeed SMC controllers device tree binding
>>>>           commit: ce9858ea499da025684a7a5f19823c2c3f14bdce
>>>> [03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
>>>>           commit: 9c63b846e6df43e5b3d31263f7db545f32deeda3
>>>> [04/11] spi: aspeed: Add support for direct mapping
>>>>           commit: 9da06d7bdec7dad8018c23b180e410ef2e7a4367
>>>> [05/11] spi: aspeed: Adjust direct mapping to device size
>>>>           commit: bb084f94e1bca4a5c4f689d7aa9b410220c1ed71
>>>> [06/11] spi: aspeed: Workaround AST2500 limitations
>>>>           commit: 5785eedee42c34cfec496199a80fa8ec9ddcf7fe
>>>> [07/11] spi: aspeed: Add support for the AST2400 SPI controller
>>>>           commit: 53526ab27d9c256504f267713aea60db7af18fb0
>>>> [08/11] spi: aspeed: Calibrate read timings
>>>>           commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4
>>>
>>> I have repeatedly objected to this patch [0][1][2] and you have
>>> repeatedly decided to not address my objections.
>> That's a very harsh way of saying things. I did not decide anything
>> or ignore your comments. I answered your questions and acknowledged
>> that indeed the read training was done under the dirmap handler but
>> this was not a concern today since we had all the required information
>> from spimem.
>>
>> We waited _together_, 5 or 6 weeks, for more inputs on how to address
>> the concerns you raised regarding the sustainability of this method.
>>
>>> I won't spend any more time fighting it.
>> This is not a fight. I don't know why you interpret it that way.
>>
>> Now, since you object so explicitly, and since this patchset has
>> not reached the Linux kernel yet, we should consider dropping it.
>> I rather do that than push crap in mainline. But then, please,
>> provide solutions and not only objections !
>>
>>> But I will say that you should not expect any
>>> guarantees that SPI NOR or SPI NAND will not break your calibration in
>>> the future if they decide to move the dirmap_create() call around.
>>
>> If that's the case one day, we have multiple solutions :
>>
>>     - stop doing the training
> 
> Not really an option, isn't it?

well, I would really rather keep the training. Else the device would be
crippled and run at low speed. 1/16 HCLK is the default :/

> 
>>     - move the training to the appropriate handler if it exists
> 
> Sorry for jumping in so late, but why not using this solution already
> if there are concerns about the current location? It does not look like
> a complex solution to implement, but I might be overlooking something.

I think we need some more feedback on this proposal [0].

If that's not acceptable, then let's discuss on dirmap_create() and
see if it would be acceptable to do calibration under this hook.
Which is what this patchset is proposing since the spimem interface
offers all the required information to do so.

However, Pratyush would prefer a stable interface, hence [0].

That said, if one day we merge a do_calibration() hook like proposed
in [0], we can change the current Aspeed patchset to use it. That's
why I didn't see the lack of specific calibration hook as a blocker.

> This can also be done for the next kernel release.

I was hoping this one. We would need a comment on the use of the
dirmap_create() hook to clarify.

Thanks !

C?dric

[0] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=233504&state=%2A&archive=both


