From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Sun, 28 Apr 2024 18:39:59 +0200
Subject: [PATCH v3 01/14] dt-bindings: spi: Document the IBM Power SPI
 controller
In-Reply-To: <f1c3947c-e1c8-4dac-bbf7-e9c0dc9c27e9@linux.ibm.com>
References: <20240425213701.655540-1-eajames@linux.ibm.com>
 <20240425213701.655540-2-eajames@linux.ibm.com>
 <e2b52bfb-0742-4baf-8269-86075b5cc54e@kernel.org>
 <f1c3947c-e1c8-4dac-bbf7-e9c0dc9c27e9@linux.ibm.com>
Message-ID: <992317a7-2606-404c-bc62-4d181ea9e147@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 26/04/2024 16:49, Eddie James wrote:
> 
> On 4/26/24 01:15, Krzysztof Kozlowski wrote:
>> On 25/04/2024 23:36, Eddie James wrote:
>>> The IBM Power chips have a basic SPI controller. Document it.
>> Please use subject prefixes matching the subsystem. You can get them for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
>> your patch is touching.
> 
> 
> Isn't spi the right subsystem here?

And what prefix shall be for SPI bindings? Did you run the command or
just replying to disagree with me?


Best regards,
Krzysztof

