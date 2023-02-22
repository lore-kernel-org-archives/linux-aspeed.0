From: Dhananjay Phadke <dphadke@linux.microsoft.com>
Date: Tue, 21 Feb 2023 17:14:07 -0800
Subject: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
In-Reply-To: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
 <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Message-ID: <d0f8d17a-bdcb-7554-b96c-99226d013fe6@linux.microsoft.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/20/2023 7:32 PM, Ryan Chen wrote:
>>>>> +? timeout:
>>>>> +??? type: boolean
>>>>> +??? description: Enable i2c bus timeout for master/slave (35ms)
>>>>> +
>>>>> +? byte-mode:
>>>>> +??? type: boolean
>>>>> +??? description: Force i2c driver use byte mode transmit
>>>>> +
>>>>> +? buff-mode:
>>>>> +??? type: boolean
>>>>> +??? description: Force i2c driver use buffer mode transmit
>>>>
>>>> These three aren't really a property of the hardware, more of the
>>>> intended driver configuration. Do they really belong in the DT?
>>>>
>>> Sorry, I am confused.
>>> This is hardware controller mode setting for each i2c transfer.
>>> So I add it in property for change different i2c transfer mode.
>>> Is my mis-understand the property setting?
>>
>> It depends what this is configuration is for.
>>
>> Would you set the transfer mode based on the design of the board? Is there
>> something about the physical i2c bus wiring (or some other hardware design
>> choice) that would mean you use one setting over another?
>>
> No, it not depend on board design. It is only for register control for controller transfer behave.
> The controller support 3 different trigger mode for transfer.
> Byte mode: it means step by step to issue transfer.
> Example i2c read, each step will issue interrupt then driver need trigger for next step.
> Sr (start read) | D | D | D | P
> Buffer mode: it means, the data can prepare into buffer register, then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling.
> The DMA mode most like with buffer mode, The differ is data prepare in DRAM, than trigger transfer.
> 
> 

Unless these settings like xfer mode are per i2c bus, it could be just a
module parameter? Not sure anything other than default mode would be
used if DMA mode works for all master/slave transactions.

Regards,
Dhananjay


