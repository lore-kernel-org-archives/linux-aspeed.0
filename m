From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Sat, 17 Feb 2024 13:42:23 +0100
Subject: [PATCH 1/3] dt-bindings: i3c: drop "master" node name suffix
In-Reply-To: <00d6a0d5-6787-4777-8fb2-dcad4304a724@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <00d6a0d5-6787-4777-8fb2-dcad4304a724@linaro.org>
Message-ID: <2024021712422352187ad4@mail.local>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 16/02/2024 12:26:12+0100, Krzysztof Kozlowski wrote:
> On 17/01/2024 08:56, Krzysztof Kozlowski wrote:
> > Drop the requirement of "-master" suffix in node names because:
> > 1. "Master" word is discouraged and MIPI Alliance renamed it to
> >    "Controller".
> > 2. Some devices can operate in Controller (Master) or Target mode, thus
> >    the name is not accurate in such cases.
> > 3. Other buses, like I2C controllers, use simple "i2c".
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> 
> Rob, can you pick this one up? It seems Alexandre did not take it.
> 

I'll take it but I don't think it is super urgent.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
