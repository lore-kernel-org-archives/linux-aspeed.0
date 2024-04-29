From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 29 Apr 2024 20:17:02 +0200
Subject: [PATCH v3 01/14] dt-bindings: spi: Document the IBM Power SPI
 controller
In-Reply-To: <b2bdae97-7cd5-4961-9cd4-1142a862d55f@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-2-eajames@linux.ibm.com>
 <e2b52bfb-0742-4baf-8269-86075b5cc54e@kernel.org>
 <f1c3947c-e1c8-4dac-bbf7-e9c0dc9c27e9@linux.ibm.com>
 <992317a7-2606-404c-bc62-4d181ea9e147@kernel.org>
 <b2bdae97-7cd5-4961-9cd4-1142a862d55f@linux.ibm.com>
Message-ID: <f817d567-1b36-4c1a-aa2c-81615ac8fe76@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 29/04/2024 16:38, Eddie James wrote:
> 
> On 4/28/24 11:39, Krzysztof Kozlowski wrote:
>> On 26/04/2024 16:49, Eddie James wrote:
>>> On 4/26/24 01:15, Krzysztof Kozlowski wrote:
>>>> On 25/04/2024 23:36, Eddie James wrote:
>>>>> The IBM Power chips have a basic SPI controller. Document it.
>>>> Please use subject prefixes matching the subsystem. You can get them for
>>>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>>>> your patch is touching.
>>>
>>> Isn't spi the right subsystem here?
>> And what prefix shall be for SPI bindings? Did you run the command or
>> just replying to disagree with me?
> 
> 
> The correct prefix is either dt-bindings: spi or spi: dt-bindings. I 
> used the former. Would you prefer I use the latter? I followed your 

The correct is the latter, although I see now Mark stopped stripping
dt-bindings in such case. Log is still suggesting that (git log
--oneline -- Documentation/devicetree/bindings/spi/ | grep "^[0-9a-f]\+
spi:" | wc -l gives 370 vs 130), although I understand now different
approach.

It's also mentioned here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html


Best regards,
Krzysztof

