From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 9 Mar 2023 15:54:25 +0200
Subject: [PATCH] spi: Replace `dummy.nbytes` with `dummy.ncycles`
In-Reply-To: <460ef5ff3846b409b322ca53559e2476@walle.cc>
References: <20220911174551.653599-1-sergiu.moga@microchip.com>
 <20220925220304.buk3yuqoh6vszfci@mobilestation>
 <18e6e8a8-6412-7e31-21e0-6becd4400ac1@microchip.com>
 <20220926172454.kbpzck7med5bopre@mobilestation>
 <1766f6ef-d9d8-04f7-a6bf-0ea6bc0b3d23@linaro.org>
 <f647e713a65f5d3f0f2e3af95c4d0a89@walle.cc>
 <1849e2c8-54f5-9e56-4ed8-8b0e4a826d04@linaro.org>
 <302ecf0421fe4c99fca3eb0ca2f66127@walle.cc>
 <5183a184-c72d-3acd-70cd-6aa1e31533f5@linaro.org>
 <03a9f117316ab81f1b5a18100f771e65@walle.cc>
 <6c2090bf-d102-a333-3a83-03abe81ff70e@linaro.org>
 <460ef5ff3846b409b322ca53559e2476@walle.cc>
Message-ID: <b8b61fc0-1e4f-146b-2036-03fda5359585@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On 09.03.2023 15:33, Michael Walle wrote:
>>>> The controllers that can talk in dummy ncycles don't need the
>>>> dummy.{buswidth, dtr} fields.
>>>>
>>>> The controllers that can't talk in dummy cycles, but only on a "byte"
>>>> boundary need both buswidth and dtr fields. Assume a flash needs 32
>>>> dummy cycles for an op on 8D-8D-8D mode. If the controller does not 
>>>> have
>>>> the buswidth and dtr info, it can't convert the dummy ncycles to 
>>>> nbytes.
>>>> If he knows only that buswidth is 8, it will convert ncycles to 4 
>>>> bytes.
>>>> If dtr is also specified it converts ncycles to 2 bytes.
>>>
>>> No they don't need it. Lets take your semper flash and assume it needs
>>> 12 latency cycles. SPI-NOR will set ncycles to 12 *regardless of the 
>>> mode
>>> or dtr setting*. The controller then knows we need 12 clock cycles. 
>>> It has
>>> then to figure out how that can be achieved. E.g. if it can only do the
>>> "old" byte programming and is in quad mode, good for it. It will send 6
>>> dummy bytes, which will result in 12 dummy clock cycles, because 1 byte
>>> takes two clock cycles in quad SDR mode. If its in octal mode, send 12
>>> bytes. If its in dual mode, send 3 bytes. Obiously, it cannot be in
>>> single bit mode, because it cannot send 1.5 bytes..
>>>
>>
>> You miss the fact that you can have 1-1-4. What buswidth do you use
>> for dummy, the address buswidth or the data buswidth?
> 
> Doesn't matter, does it? The driver is free to chose, 1, 4, or anything
> else. You don't sample any data during the dummy phase.
> To answer your question: single for instruction, single for address,
> whatever you choose for dummy as long as there are ncycles space between
> address and data, and quad for data.

Huh? How does the controller chose, based on what?

> 
> Depending on the capabilites of the hardware it will likely be 1 or 4.
> 
>> What happens if crazy protocols like 1S-1S-8D appear? What buswidth
>> and transfer mode are you going to use for dummy?
> 
> Also doesn't matter. What matters is how many dummy clock cycles you
> do. Again, they don't depent on the mode. You just have to count
> the clock cycles between the address and the data phase (and that is
> what your ncycle parameter will tell the controller).
> 
>> And please don't tell me that "we're going to assume that
>> dummy.buswidth = address.buswidth because that's what we currently do
>> in SPI NOR", because I'm not convinced that the assumption is correct.
> 
> No, it doesn't matter :)
> 
> -michael
