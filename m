From: Florian Fainelli <florian.fainelli@broadcom.com>
Date: Wed, 14 Feb 2024 18:41:43 -0000
Subject: [PATCH 3/6] arm64: dts: Fix dtc interrupt_provider warnings
In-Reply-To: <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
References: <20240213-arm-dt-cleanups-v1-0-f2dee1292525@kernel.org>
 <20240213-arm-dt-cleanups-v1-3-f2dee1292525@kernel.org>
Message-ID: <af372c4a-0b7b-45b6-a3bf-3f17ba2eb3a5@broadcom.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2/13/24 11:34, Rob Herring wrote:
> The dtc interrupt_provider warning is off by default. Fix all the warnings
> so it can be enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>   arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com> #Broadcom
-- 
Florian

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4221 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240214/dabd9eaa/attachment-0001.p7s>
