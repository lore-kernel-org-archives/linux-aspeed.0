Return-Path: <linux-aspeed+bounces-524-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAEDC02183
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Jan 2025 14:32:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZMdK4sKZz30WX;
	Sat, 18 Jan 2025 01:32:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737124341;
	cv=none; b=JbHUfFmD+i5lGP2PJ1kX8WUZSTLbv+LBQNnu5QkNjuQJJtDbV2vx+G/Sm0fzyPfAO6MnfihwhRVIn1OIXpzfBlrtGdMqLjkxaoCdp6/JDV9jI6LlXFPavlfCL0O4lQX2H68MSedG7GJMDyH35qRfU53/2Jke9pBTMPXyi+LBs4NI6R0SwENrcNtWANV7qd/cjdG16FtAlTeMGIZ+aGiHXWwh5nVhy1faYbc7nRqiu8rckDZjjYAAP1Xl1y7TroSRMxS206LJeRLMPXiYPEpTQhC2X25yDnj6Rhj7UFt7vomKo2NL1C3/VKTTLoPrDnV/wVAqFtNPImMYnNMBRGYOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737124341; c=relaxed/relaxed;
	bh=FQLYVwticC0pQgJuG9CmU0MdkMzypGHsD12XmJ4q2jg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=hV5bgUQNFNKfWLrhB9UFzR0wtI8Xuv8I6VUHR5R16ntetLiDG8uVHiZgvERT8Q4+RwOCZf6SkdMhqk70BzasoaKl/DzaGJ8tqS+Ll3Gk4a74X7XpQE1txEC+QoyZpGZlekDi4rNPQ2ALUhag08YazFKZ1TVRYEWUsD2jphgcafqN1lH+sVvR0ODYsavA9HSNeVZk+kM2JZEoEUW6R2XjCRLFftDNHdGFGujBFyjmNwrbJcrpuEkEdna91qRPfPGsFgnjEcmss/WhaPyXSdszrXYXzShXw7JRnzn4I1Feuy/sLlPX35rZ4eIe0hvLGdif1AbJswnlClz+e9uyM1JtZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CWHqKh+C; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CWHqKh+C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZMdJ3R33z30WP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 18 Jan 2025 01:32:20 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 83508A430C7;
	Fri, 17 Jan 2025 14:30:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A352C4CEE3;
	Fri, 17 Jan 2025 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737124337;
	bh=26g0fdxxXJS5fHlyq0dbUxYx22VrCNq5Mgdt7Hy5xBQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CWHqKh+C4dmpNScj3bVkG9IP168qiggK99/98sB2wCn6tw0jwJzB4HERKmwu62sAq
	 +hr4YlCkAbXMxmJ7LYaTtJLEZvXPcQ9Eu1pRpSkumVapMDIDtL9Mf/QTfNA2t+BS4W
	 cIdStQ0vnrgUmHfSHfHQApJW1OiANlbcnkjudEhLYNoKU33uzgsrU+p23v+SPOUx+O
	 xsBtmk0IZJ1yE8thG2Jn+wF/pJZNJiksjsW1WmHWf0nw+/0UFLGDwrcGQtgBp/wShy
	 OVO084Oe1tr+yU1E+QGU7YtJGXWz13XDa4Pm0c4ZSo/Y38uxKRmXAfeDR+5238m/6I
	 HZDb4BBJKz7Nw==
Date: Fri, 17 Jan 2025 08:32:15 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, joel@jms.id.au, 
 linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 elbadrym@google.com, linux-kernel@vger.kernel.org
To: Kevin Chen <kevin_chen@aspeedtech.com>
In-Reply-To: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
References: <20250117095217.661070-1-kevin_chen@aspeedtech.com>
Message-Id: <173712392559.810318.5052005402329647545.robh@kernel.org>
Subject: Re: [PATCH v0 0/3] Add AST2600 LPC PCC support


On Fri, 17 Jan 2025 17:52:14 +0800, Kevin Chen wrote:
> The AST2600 has PCC controller in LPC, placed in LPC node. As a result,
> add LPC PCC controller driver to support POST code capture.
> 
> Kevin Chen (3):
>   dt-binding: aspeed: Add LPC PCC controller
>   ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
>   soc: aspeed: lpc-pcc: Add PCC controller support
> 
>  .../bindings/soc/aspeed/lpc-pcc.yaml          |  51 ++
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi       |   7 +
>  drivers/soc/aspeed/Kconfig                    |  10 +
>  drivers/soc/aspeed/Makefile                   |   1 +
>  drivers/soc/aspeed/aspeed-lpc-pcc.c           | 505 ++++++++++++++++++
>  5 files changed, 574 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/lpc-pcc.yaml
>  create mode 100644 drivers/soc/aspeed/aspeed-lpc-pcc.c
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250117095217.661070-1-kevin_chen@aspeedtech.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-quanta-s6q.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-fuji.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-transformers.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-inventec-starscream.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtjefferson.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ufispace-ncplite.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ampere-mtmitchell.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dtb: lpc-pcc@0: 'interrupts' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/soc/aspeed/lpc-pcc.yaml#






