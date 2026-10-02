Return-Path: <linux-aspeed+bounces-5113-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5AACA5FD4
	for <linux-aspeed@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxF7S4lcLz30RN;
	Sat, 03 Oct 2026 02:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:33::c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790959636;
	cv=none; b=oVO3GW/VcTGQ6ghdy/cHS/y+IarMWywAoBFYuv6E9Gl8nBG2epF7vweqAywuGuGQLtMW32RVuMcESC/IzyKrvV+DvPU3HF2x2/CYhK7h4pAyXv0vA1QpqLV7uaYivgKfWChZxhnlu3x+8E02Bn72VOX5gobQgzTDaW6/mYa09ZHUBj1RD9skyWICYJteNcZ9X4XR/lWcYOzXWg3Jzt7+NCaDpbSGcV3X14jG6/uax7X1x5xdlT+4yQnoFbjJhyUlRuhjV/CrwaPpn+wosu/Mb3Nd2xelEZQl4ftxTFJkF4M5cFbp5iVc/ufJoJuz9Ibohbv/buy1124SEFKtvDVhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790959636; c=relaxed/relaxed;
	bh=gQxZFNe1rWBibsrSm2fJpFRrCL8XwGmShlpoXQZ+uig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWNx0dKswSOKrllQH+rHN91V7y4uWKvD3rDSi4NZGuNp+mvvU5bK2bqnEdrkw9EKGXfMkvZJROio/EEcSyBqZ6D7Nb0R35kkf212ZmTHCf4jPVjLYeKXQM5yaG5v6SJGprXbSTRhboIuxcaCobIE0U4uSvQ7KBxF509Bg7Y5l0vO+w707bPtocOIj6/b5nsHimu+oHLO7ImjWFn6JjNab9qUUEa9uXeDM/9Dr+C+RrDICS1fB63q4pwB/LQGcLy5ifOjiJmGy/ZLa+Xl7yh4hsOasD1M2FHhnbXQOa/X7OH7R0WSpZvwRp5L++4Ut+Q5kFFZ1dmSkPiQG73zTFobFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FFizQtnl; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:33::c; helo=mail-ed2-x0c.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=FFizQtnl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:33::c; helo=mail-ed2-x0c.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-ed2-x0c.google.com (mail-ed2-x0c.google.com [IPv6:2a00:1450:4864:33::c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxF7Q5jSXz30Qv
	for <linux-aspeed@lists.ozlabs.org>; Sat, 03 Oct 2026 02:47:14 +1000 (AEST)
Received: by mail-ed2-x0c.google.com with SMTP id 4fb4d7f45d1cf-6acac47206aso6433681a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 02 Oct 2026 09:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1790959631; x=1791564431; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gQxZFNe1rWBibsrSm2fJpFRrCL8XwGmShlpoXQZ+uig=;
        b=FFizQtnlun5Q72UmOcu3wWv50fA0kiPK/5yIbFvSuLMjoRZ6ZlpillclA3yMqT4odJ
         aVT+Ntdbgt6W3GJbGFeAR0h5hDPfGR03DoCV1hr5bihpsXsGHAIgwXqlBdRyUnJiuIZW
         /DwpL+zY7eWtNKi8X8WWT5tACUrjFM3qWwxCjFIQM9P2eyWgsZdUD11rSKWo9W9dXHnS
         ACoY3UAhRQia+WV2a8M2pOpWPbWMGZ37ZIcG4AFOCN2sCVQByDs3Oc8e5ugWiEtZUGjD
         9O9P0YPrqauVQUEMsrBm9TKA3YKRWMZdgbikm/hbmuH02HsgfwC8bIPcKTM8FPSbG/+G
         aL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790959631; x=1791564431;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gQxZFNe1rWBibsrSm2fJpFRrCL8XwGmShlpoXQZ+uig=;
        b=vEnU3eErlXfUL4Fb25wQZtQ1yAU+iYTkCbQEK853o7TSOInGVUMWv3uwUGA6Sgu/nW
         kjDcQwHYGz3kjotLcyjlVCBYPqVLu5GGTzGUNVOjqp+Px4JtQ6bfNFL8Za/OmXonHztW
         rs2WR0vjbuemseQ/++rALwqY/y8nSVgZ/Ak3rGb9g8Xew6QX1YTxuRsL+PHUMbNI8eR/
         PNNACdIkNRcmytn/wUfXNqFFxTUI0zaqn2o7SvcprlwwzUpIxnv3EHi5dNxGhA+h++va
         i4w/l6FaxClrKfmZwwxxPx7ySK3cRq6FmsCRBF5JCh0GVPJTqheyvrxQNHSbxZPUiWJv
         28bQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrdoAaYlxiJbN299Eqh56X0nb5epzGzBBTZWFAO1+agXvCKgIA2UTFtjJnsFZZI8W4Eso839AYKw9iqMc=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIfhtTxhFx51E2bgeiT76yYNjtenXw9Mk3tqmYjE3lnsvVZ1Fc7
	F+jCXzBlJDqlF4KX9corLpH2xpUl6GqGpXczZYXR+1LQVRFSFnSqV27JTIqkbsjV9Kk=
X-Gm-Gg: AYBFou3//0SI2vEiMjpgUpmzrxbr2aXI8/3/irjIC2y+1JRoBntjUsm9ehT1xRaDIRx
	HSoVz5rhkMbz+mnLcweZPmTH7raLUX9x1Zjv6kx/5VEHHAKp/Mj3XdvzT6WRMt0ChpuLvrI5Svk
	gD7HCv8zgg6PAHdmjASAPgt4tkDYWCWdTJqqCgI0HNFCo+K/y7Z4vPS7zh5HFkUcSP4if2ZHacj
	5Zb2ivGNhDuDckgBlL7KHIv36JEKxC002DNmFLzddWuXesBFr0Lmrfp0mcnJqBJ2RvhUJGfYN7X
	b/MBeAWG2w5np0zcyiwbCFCHD3FrOi9irK8/6UFwF6PVfRaxkYy55QuM78I3gEhyrKyS0JVti+t
	L0uZy0EK1jj0Coo6Zm67QRxqe9eJcaVQXDSxPWKpn9eFjto8t12NsXeBp0OTmyV8IjAF92klR7g
	tY575EUhXkyV9qUdxHypdEGYGSsRVkGdU5FLmp29mZMJkggfgbdFdc5oUFinGD3Hlo10TTvJYTC
	QpB1G2IXfjUkyExnxv3PpCTrxjfeb4+KsuQuOOQj6jBAvUs+EM=
X-Received: by 2002:a17:907:c02:b0:c2e:4292:d268 with SMTP id a640c23a62f3a-c2e4aac822amr274357466b.16.1790959631108;
        Fri, 02 Oct 2026 09:47:11 -0700 (PDT)
Received: from ?IPV6:2a01:599:841:224a:bb33:b9f8:dc3b:fc30? ([2a01:599:841:224a:bb33:b9f8:dc3b:fc30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cf680ddsm101999566b.52.2026.10.02.09.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 09:47:10 -0700 (PDT)
Message-ID: <9cfcd3e7-bbc3-47c6-ad43-72b595a90110@9elements.com>
Date: Fri, 2 Oct 2026 18:47:09 +0200
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
Subject: Re: [RFC PATCH] soc: aspeed: Add B650D4U power passthrough support
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, joel@jms.id.au, ryan_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>
References: <20261002131634.113680-1-prasanth.padarthi10@gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <20261002131634.113680-1-prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/26 3:16 PM, Prasanth Kumar Padarthi wrote:
> Add the AST2600 SCU passthrough selector support used by the
> ASRock Rack B650D4U host power-control circuit. This RFC includes
> the driver, Devicetree binding, and board node to discuss the final
> kernel-facing interface.
> 
> Signed-off-by: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>

This is definitely not the way how to solve this. I've already said on 
linux-aspeed as well as off-the-list, requesting the GPIO lines is 
enough and enabling GPIOP passthrough here does not make any sense, as 
it would be disabled by pinctrl anyways.
There's a whole implementation in userspace to solve this issue (at 
least if you use OpenBMC). The issue you're facing here is, from my 
point of view, a configuration error, and you'll not solve it with a 
kernel driver that literally just enables GPIOP passthrough...

So my answer to this patch is:
NACKed-by: Tan Siewert <tan.siewert@9elements.com>

> ---
>   .../asrock,b650d4u-power-passthrough.yaml     |  23 ++++
>   .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  |   5 +
>   drivers/soc/aspeed/Kconfig                    |   9 ++
>   drivers/soc/aspeed/Makefile                   |   1 +
>   drivers/soc/aspeed/aspeed-b650d4u-power.c     | 110 ++++++++++++++++++
>   5 files changed, 148 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
>   create mode 100644 drivers/soc/aspeed/aspeed-b650d4u-power.c
> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
> new file mode 100644
> index 000000000000..e6451d17955c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/asrock,b650d4u-power-passthrough.yaml
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/aspeed/asrock,b650d4u-power-passthrough.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASRock Rack B650D4U power passthrough
> +
> +maintainers:
> +  - Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: asrock,b650d4u-power-passthrough
> +
> +  aspeed,scu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - aspeed,scu
> +
> +additionalProperties: false
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> index a4e384588a54..86291c250562 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts
> @@ -32,6 +32,11 @@ gfx_memory: framebuffer {
>   			size = <0x01000000>;
>   		};
>   	};
> +
> +	host-power-passthrough {
> +		compatible = "asrock,b650d4u-power-passthrough";
> +		aspeed,scu = <&syscon>;
> +	};
>   };
>   
>   &fmc {
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index 11e4db998c06..1b0281e0bfb0 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -58,6 +58,15 @@ config ASPEED_SBC
>   	  Say yes to provide information about the secure boot controller in
>   	  debugfs.
>   
> +config ASPEED_B650D4U_POWER
> +	tristate "ASRock B650D4U host power passthrough"
> +	select REGMAP
> +	select MFD_SYSCON
> +	default ARCH_ASPEED
> +	help
> +	  Enable the AST2600 GPIO passthrough selector used by the
> +	  ASRock Rack B650D4U host power-control circuit. This selector routes the host power pulse through the board's passthrough logic during power sequencing.
> +
>   config ASPEED_XDMA
>   	tristate "ASPEED XDMA Engine Driver"
>   	select REGMAP
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index 5f61bb4cc36c..3e9618d1eafc 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -5,4 +5,5 @@ obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
>   obj-$(CONFIG_ASPEED_P2A_CTRL)		+= aspeed-p2a-ctrl.o
>   obj-$(CONFIG_ASPEED_SOCINFO)		+= aspeed-socinfo.o
>   obj-$(CONFIG_ASPEED_SBC)		+= aspeed-sbc.o
> +obj-$(CONFIG_ASPEED_B650D4U_POWER)	+= aspeed-b650d4u-power.o
>   obj-$(CONFIG_ASPEED_XDMA)		+= aspeed-xdma.o
> diff --git a/drivers/soc/aspeed/aspeed-b650d4u-power.c b/drivers/soc/aspeed/aspeed-b650d4u-power.c
> new file mode 100644
> index 000000000000..22a6925539dc
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-b650d4u-power.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mutex.h>
> +#include <linux/kstrtox.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/bits.h>
> +
> +#define ASPEED_SCU_PROTECTION        0x000
> +#define ASPEED_SCU_GPIO_PASSTHROUGH  0x4bc
> +#define ASPEED_SCU_GPIO_ACTION       0x51c
> +#define ASPEED_SCU_UNLOCK_KEY        0x1688a8a8
> +#define ASPEED_B650D4U_POWER_MASK    GENMASK(27, 26)
> +
> +static struct regmap *b650d4u_scu;
> +static DEFINE_MUTEX(b650d4u_lock);
> +
> +static int b650d4u_set_passthrough(bool enable)
> +{
> +	int ret;
> +
> +	mutex_lock(&b650d4u_lock);
> +
> +	ret = regmap_write(b650d4u_scu, ASPEED_SCU_PROTECTION,
> +			   ASPEED_SCU_UNLOCK_KEY);
> +	if (ret) {
> +		pr_err("B650D4U: SCU unlock failed: %d\n", ret);
> +		goto out;
> +	}
> +
> +	ret = regmap_update_bits(b650d4u_scu,
> +				 ASPEED_SCU_GPIO_PASSTHROUGH,
> +				 ASPEED_B650D4U_POWER_MASK,
> +				 enable ? ASPEED_B650D4U_POWER_MASK : 0);
> +	if (ret) {
> +		pr_err("B650D4U: passthrough update failed: %d\n", ret);
> +		goto out;
> +	}
> +
> +	if (!enable)
> +		ret = regmap_write(b650d4u_scu,
> +				   ASPEED_SCU_GPIO_ACTION, 0);
> +
> +out:
> +	mutex_unlock(&b650d4u_lock);
> +	return ret;
> +}
> +
> +static ssize_t passthrough_store(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	bool enable;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
> +
> +	ret = b650d4u_set_passthrough(enable);
> +	return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(passthrough);
> +
> +static int aspeed_b650d4u_power_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	b650d4u_scu = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +						      "aspeed,scu");
> +	if (IS_ERR(b650d4u_scu))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(b650d4u_scu),
> +				     "failed to get AST2600 SCU regmap\n");
> +
> +	ret = b650d4u_set_passthrough(true);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to enable power GPIO passthrough\n");
> +
> +	ret = device_create_file(&pdev->dev, &dev_attr_passthrough);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to create passthrough control\n");
> +
> +	dev_info(&pdev->dev, "enabled GPIO passthrough selector 1\n");
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_b650d4u_power_of_match[] = {
> +	{ .compatible = "asrock,b650d4u-power-passthrough" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, aspeed_b650d4u_power_of_match);
> +
> +static struct platform_driver aspeed_b650d4u_power_driver = {
> +	.probe = aspeed_b650d4u_power_probe,
> +	.driver = {
> +		.name = "aspeed-b650d4u-power",
> +		.of_match_table = aspeed_b650d4u_power_of_match,
> +	},
> +};
> +module_platform_driver(aspeed_b650d4u_power_driver);
> +
> +MODULE_DESCRIPTION("ASRock Rack B650D4U host power GPIO passthrough");
> +MODULE_LICENSE("GPL");


