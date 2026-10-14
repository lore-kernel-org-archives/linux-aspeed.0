Return-Path: <linux-aspeed+bounces-5191-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9564ACC6B27
	for <linux-aspeed@archiver.kernel.org>; Wed, 14 Oct 2026 08:28:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4PVG0NBFz2xM9;
	Wed, 14 Oct 2026 19:28:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791966501;
	cv=none; b=UP6XkbRub/bwQz9kxFlVRsi8M5L6qFxtNDae9HashWDLgKWMjlOAaSpc4XXDh+QgLUhZuKvUOzPTLUbNk7b24ORYWv3GcCij/Qo43cQv2e9iTmW4U9lb8/OYPc2KbTUoGDGj4hk3IzSbOyEdiAOk2HqeEcMUISduLf1EQ31PqVFAicvM8vUqlIcAP3psrWzAHptnpo6BIXR3ejBiyq0v65rbF1jmurxNJkYI923ERapUuJMZawi5Q+S4bODICEkJWSEVTIIDyV1r3WO9OQ+aY1CAPbx3aQC7EsL4WhJx6Ohq1tweyHjoPm9Y8qxSKUxUm0GIoa9Nt6n7ix3iUDVHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791966501; c=relaxed/relaxed;
	bh=BEWX0NnWZSM0xUTF33KaixK1TLeuUgRnotvYl3b7sMI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jdyh1QyzA+sEFudwIANt7POjx71TZyUsEiVMO9Xqr3GTnyKQTGJUL2iM2+8sPjn7hLxuJxw/xrUPcYZB4vwbTzGNA/MhcT/c/JxPScX52UPsIOLkyez284KH0HpOIRhJFIsBkt7zQnAvQ3EgyZS+ERIQsZwJHv8kkHRRcucLyrV8flKgiLM7RZdG72oyae9QWxyCPXcY0Y0daG1ZR/upLYsPzdHc4mjnG3ixW6RQ2Cn/lnXby0SsNYt/2IllrvK2MBl4spMRHyZ5109gLRcT/umWJs6BxYXlIWaT6oWHg028B5GV7eMxk5rdNLypU7HEi8tf0kqZi+ZnI7jNv2udpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVynnI9D; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wVynnI9D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=neil.armstrong@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4PVD6gNgz2xLf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 19:28:19 +1100 (AEDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-49fbb2acc90so32629635e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 14 Oct 2026 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791966494; x=1792571294; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BEWX0NnWZSM0xUTF33KaixK1TLeuUgRnotvYl3b7sMI=;
        b=wVynnI9Ds4AIRPKk/GkJueaE7ZZEIiWjqrgRAmY37uMCcyYMu+jFzjAt+zy2b8FT/J
         7nnCq0ol3P6yyRgwIiBlfgyDu5J0gWV5skbv62abfLJFHJ7m8I9QliUimvGwj4QqyVgM
         i8fUhgwnzBjLoO2jQ3JRDWfnBqR2lr4reGlUJq3G1JuqDNiBkSOrfbebfEfh0beFvztq
         Z7mReczgMY81S4k1j4SBO+jH6erbBVJGpAtfE7eTFZ1DscQT39Cdj6m+8hKHi1xwyy4e
         PVMzoFU6hdoyFchNFM5g71AWEHwMXL3xAxmt9Bpzw9MCgD2jgnHdlyhAJOEKzG8svRXi
         Y64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791966494; x=1792571294;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BEWX0NnWZSM0xUTF33KaixK1TLeuUgRnotvYl3b7sMI=;
        b=spwO0KH9F/p+Xzb54UMYDS0/0Qq1Uo+od3PzRD7+f7B4rJsvaczKuXnoPREKUkcRBk
         J+6G1/+lgG2HtD1pDO6YiHkKES6lfWTSp62E3ySmtJoidq99AjtkeyYDOV49gSNG4tkE
         daxudnXcOvfsL4LIiLS909mCG7FfVogJgdu66pV+2xXaRE/JQv33b0FyO4P1cls+2SPd
         a2Zs0R98gx7U69P0kLQIPGZvJA+WBHK4itcAwaNZFYeCW2kHXNKDwcnW/Eb0n1mwbYoc
         w9ciHvrZzXs2NzsPX2To3wg79mWfDwv02/q2ttYlWF7bOhq2PzU7r8Jclr5RvFJnfC+b
         5jgA==
X-Forwarded-Encrypted: i=1; AKwUvBwjCnxd43ax1yKa17NvuuJjUbDtYeUTkaQ1TfhyFJV1ko8F6j74J1rymYG+y7S7+3mC4N4bAvzxpTIK6Rs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIzPeRkV3GzVb3T2fPMt+laAfs6ua2xCo2ExYdkyLrmljRDWRQ6
	Ax2W3WKYi4K7GIZUiHn+fAFXRTsXF7+Un0NmPS3hGbXI+8+oY4UXxjClLRLcGCH6vs8=
X-Gm-Gg: AYBFou208lAQlKqH8kAknGZoriVjO0rjkuWlvc43kkZxVnO9eAebCv44GqB51MeNc7E
	ucNeAmKdwcJXmSmQHsBLntaBixXOWIhp/WNg+C4dRE23MkKRb8VDxAMb3UyuvsNPgeAkzJVri3T
	QYHs3CMJE1m5DG3teEl9cxFuhgHjqDlXNVixMpsahYoRzDESmzWMdtiu90h9V9CMVWEN0IkSR2W
	kJ5c/fx/x+6pK21EiLNmyPdAciJQLCzgEltKWjLjB6F67b+wG3qU9efF6KNrl/nSm4j6YEMyu5l
	bZb4GQpx7va2D+nvxOT1HHbw5Qx+xGyenvMUnvrWejwSqKql9j06BJgGY0GZauJVqTad6kJwdS4
	i3XBHxjEcCQs1iOWJk0HQwpTJml46pXHjctFwDAy3WC+uQYlFrviVsvziGglD6j1c0ZWkzhEwfF
	S/iekx7Zzit8hS+sq0ZaXJFY0EUVlPnKzY3V4SyR3VMrSVq6DddEfarE52PKDZmMA9SrINd8Xdi
	ooZuTjSo+ZI6JpsyIZXkS+pTM2rrGqzz9rJSWfttB3J600zcIMv5nc=
X-Received: by 2002:a05:600c:8b04:b0:4a0:1e37:ae41 with SMTP id 5b1f17b1804b1-4a18e4d67edmr291581105e9.24.1791966494135;
        Wed, 14 Oct 2026 01:28:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb? ([2a01:e0a:106d:1080:ef1f:5ab3:36fa:3ccb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b4b8a184sm17182865e9.2.2026.10.14.01.28.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 01:28:13 -0700 (PDT)
Message-ID: <7020a7a6-332e-4fd0-a659-d82eb768614c@linaro.org>
Date: Wed, 14 Oct 2026 10:28:11 +0200
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] dt-bindings: usb: snps,dwc3: Fix downstream port
 numbering
To: Chen-Yu Tsai <wenst@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Michal Simek <michal.simek@amd.com>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, Alim Akhtar <alim.akhtar@samsung.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Wei Yang <yangwei1@eswincomputing.com>,
 Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
 Hang Cao <caohang@eswincomputing.com>, Li Jun <jun.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Roy Luo <royluo@google.com>,
 Yang Xiwen <forbidden405@foxmail.com>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Robert Marko <robert.marko@sartura.hr>, Xu Yang <xu.yang_2@nxp.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Stanley Chang <stanley_chang@realtek.com>, Ze Huang <huang.ze@linux.dev>,
 Aswath Govindraju <a-govindraju@ti.com>, Roger Quadros <rogerq@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-aspeed@lists.ozlabs.org, imx@lists.linux.dev,
 linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev
References: <20261014082037.1774672-1-wenst@chromium.org>
 <20261014082037.1774672-3-wenst@chromium.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261014082037.1774672-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/26 10:20, Chen-Yu Tsai wrote:
> The DWC3 controller can operate in host mode. It does so with a XHCI
> compliant host controller. The XHCI has two downstream ports, one for
> HS and one for SS. USB downstream ports start from 1, not 0.

Is there something in index 0 we will need to define at some point ?

Using 0 as base for numbering in DT isn't incompatible with the USB
spec using base 1 for numbering,

> 
> Reconcile the downstream port numbering with the common USB host
> binding, renumbering the downstream port numbers from 0 and 1 to
> 1 and 2.
> 
> This is non-backwards compatible, however it won't break current
> major implementations:
> 
> - dwc3 "gadget mode" in Linux kernel only requires a connection to be
>    present; it doesn't matter which port it is
>    - dwc3 "host mode" OF graph connections aren't supported yet [1]
> - FreeBSD doesn't use the OF graph for anything
> - U-boot doesn't use the OF graph for USB
> - OpenBSD doesn't support dwc3, only the XHCI in dwc3, and doesn't use
>    the OF graph for USB
> - coreboot doesn't use the OF graph for anything
> - Zephyr doesn't support dwc3
> - TF-A doesn't use the OF graph for anything
> - EDK2 doesn't support dwc3 and doesn't support OF graph
> - OP-TEE doesn't support dwc3 and doesn't support OF graph
> 
> [1] WIP to tie OF graph port node to USB port device
> 
> Fixes: a33113f73693 ("dt-bindings: usb: snps,dwc3: document HS & SS OF graph ports")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> It is unclear to me whether the HS/SS numbering is fixed for all dwc3
> variants. I checked Allwinner H616 and Rockchip RK3588 and they both
> have HS as port 1 and SS as port 2.
> 
> This also doesn't cover a potential "multi-port" DWC3 implementation,
> which Qualcomm seems to have.

It breaks the current Qualcomm numbering on numerous boards.

> ---
>   Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> index 6c0b8b653824..4b6304bd2ec1 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3-common.yaml
> @@ -410,11 +410,11 @@ properties:
>         property is used.
>   
>       properties:
> -      port@0:
> +      port@1:
>           $ref: /schemas/graph.yaml#/properties/port
>           description: High Speed (HS) data bus.
>   
> -      port@1:
> +      port@2:
>           $ref: /schemas/graph.yaml#/properties/port
>           description: Super Speed (SS) data bus.
>   


