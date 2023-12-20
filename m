From: Patrick Williams <patrick@stwcx.xyz>
Date: Wed, 20 Dec 2023 06:38:59 -0600
Subject: [PATCH v8] ARM: dts: aspeed: Adding Facebook Bletchley BMC
In-Reply-To: <20231220080733.GA30641@wunner.de>
References: <20231220080733.GA30641@wunner.de>
Message-ID: <F444BFCC-1D44-4AF6-A0E1-B153A217FFE3@stwcx.xyz>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


---
Patrick Williams

> On Dec 20, 2023, at 2:07?AM, Lukas Wunner <lukas@wunner.de> wrote:
> 
> ?On Tue, Dec 07, 2021 at 05:49:24PM +0800, Howard Chiu wrote:
>> Initial introduction of Facebook Bletchley equipped with
>> Aspeed 2600 BMC SoC.
> [...]
>> +        tpmdev at 0 {
>> +            compatible = "tcg,tpm_tis-spi";
> 
> What's the chip used on this board?  Going forward, the DT schema for TPMs
> requires the exact chip name in addition to the generic "tcg,tpm_tis-spi".

Why is this a requirement?  This assumes there is exactly one chip. TPMs are often placed on a pluggable module in which multiple vendors could be used. There is no way in the DTS to specify multiple compatible chips. 

>> +            spi-max-frequency = <33000000>;
>> +            reg = <0>;
>> +        };
>> +    };

