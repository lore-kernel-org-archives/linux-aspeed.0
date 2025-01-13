Return-Path: <linux-aspeed+bounces-447-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F02C02180
	for <linux-aspeed@archiver.kernel.org>; Mon, 13 Jan 2025 15:26:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YWx1Q6jnfz3cXv;
	Tue, 14 Jan 2025 02:26:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736781978;
	cv=none; b=nRKL0PqOdhYtbSpUP/LzDbuMxLb3+31DGGJh5V8Bj33Mf5Bchy2T+TSe6TDEi0qN/6u4VEF7S+Nfg/UA4ZZj9lUDSFFu8Sw5tz7+uFjN9KAnS25uUda3LZZOFBsVu86/wGXFN3CIvlU5iD0hp4C67a9hhHHotBHWvvNTAVqC6JjIRxAY5oEgvk2xaBPmlXgxJG3ONDgi9e/t8B8Bv6fEoivUI8w1/01LKHrheDwOKyB2PCbenTB/aYtplNjjqYazDdCde+UFzxeop/e0sT/qzNR0ZA9kL5XJT4dx01MCDzQ9ewbbmHKYRcJ88HZXOHfqdkr49Hc5j2mC8NuWBybHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736781978; c=relaxed/relaxed;
	bh=pCexijReCLDALyBYDT/wveBapsUoKXzsuwJVO6B+djg=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=SYqrzJtCP3nT18eIB0BTzhqGZvQAbkGXfxtdPBHXHf+ouph1XlDhXNEFaz86Ux/uJ2N4Nedi4//IOboRJxubEgR4cZKIEAjnTY7odw9V4CCbixFa7dgUWSx1BVXsbUoMRxRkfAxcMpChRhcqothoZtX6tXqgTHVM59Jn/RiGbs0WH3AFxC6zl1ZEA3xnpb7O3ZHTvnuMJNNvqLot3Q08wdGaauRlBF4ZZKjfeGybaGvj76NJ3766n/0/Tjh+CqfUMIyy79Gu9Gzm64KHZclGzqJ25fpJx3gQjzaU1hn2zv4n/iEutaWb28AQLqFwhd6MmHi8XtqkI/eltJxXsDhuBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSDMpSA6; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSDMpSA6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YWx1P16qkz3cWB
	for <linux-aspeed@lists.ozlabs.org>; Tue, 14 Jan 2025 02:26:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 299B25C4C14;
	Mon, 13 Jan 2025 15:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA5F9C4CEE3;
	Mon, 13 Jan 2025 15:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781971;
	bh=mgTx6aOYLPXtqcfI3g1VHKq5JpmA5YkehPbZVMZdgaY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=dSDMpSA6C7sZPmyjE97Q3KaGNovHhACtHy3/gldzUUQqt9qeDYLvlneExcnp17wec
	 aGF6aHuF648gSUljdj7UGdneY2TzkuZUQKHYM23k6PZDdCIn24Jn5aw4QWm8CQw3uy
	 TcGDVNQLuJhTaTJnT1sOvQnROTcb1NfDd7PYRJzHz8uMUbUZLztdDoRvUERcE9Qu2k
	 zrpoeT4L4CMextWc8WgHGUmFXmO7lrc+92rsTeqV8o+nNyIf3MTkCKXv4sRlmgvx7k
	 YraJ4NYWaU9a6ffYM1hGo0tuEB3Imd/BikEWjpw71do+MOUdhBx7rBt4ideXfkwSK/
	 aWfifrReyTnpg==
Date: Mon, 13 Jan 2025 09:26:10 -0600
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
Cc: linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 linux-arm-kernel@lists.infradead.org, Patrick Williams <patrick@stwcx.xyz>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com>
References: <20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com>
Message-Id: <173678161661.2153651.3945745286602645687.robh@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: aspeed: catalina: Update DTS to support
 multiple PDB board sources


On Mon, 13 Jan 2025 14:16:23 +0800, Potin Lai wrote:
> This patch updates the Catalina device tree to support different sources
> of PDB boards.
> 
> Changes for Main source PDB board
> - Thermal Sensor Monitoring:
>   - Added IOB NIC nodes (TMP421) for thermal sensor monitoring.
>   - Added FIO remote thermal node (TMP75) for thermal sensor monitoring.
> - Fan Monitoring and Control:
>   - Add fan p12V power sensor node (MP5990) for sensor monitoring.
>   - Add fan controllers (MAX31790) for fan control and tach monitoring.
> 
> Changes for 2nd source PDB board
> - Fan Monitoring and Control:
>   - Added 2nd source fan controllers (NCT7363) for fan duty control and
>     tach monitoring.
> - Power Monitoring:
>   - Added 2nd source HSC nodes (XDP710) for power sensor monitoring.
> - Address Conflicts:
>   - Removed all ina238 nodes due to address conflicts. Moved the driver
>     probe for ina238 to userspace.
> 
> Changes for PDB brick board
> - Power Monitoring:
>   - Add delta brick nodes for power sensor monitoring.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Updating the Catalina DTS to support multiple PDB board sources.
> ---
> Changes in v2:
> - Add delta_brick nodes to support PDB brick board
> - Link to v1: https://lore.kernel.org/r/20250103-potin-catalina-dts-update-20250102-v1-1-b0b7a523c968@gmail.com
> ---
>  .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 170 ++++++++++++++++++---
>  1 file changed, 147 insertions(+), 23 deletions(-)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250113-potin-catalina-dts-update-20250102-v2-1-1725117fe7a9@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dtb: /ahb/apb/fsi@1e79b000/cfam@0,0/hub@3400/cfam@1,0/i2c@1800: failed to match any schema with compatible: ['ibm,fsi-i2c-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dtb: lpc@1e789000: lpc-snoop@90: 'clocks' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1e78a000/i2c@100/i2c-mux@70/i2c@3/delta_brick@63: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1e78a000/i2c@100/i2c-mux@70/i2c@3/delta_brick@64: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1e78a000/i2c@100/i2c-mux@70/i2c@3/delta_brick@65: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1e78a000/i2c@100/i2c-mux@70/i2c@3/delta_brick@66: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dtb: /ahb/apb/bus@1e78a000/i2c@100/i2c-mux@70/i2c@3/delta_brick@67: failed to match any schema with compatible: ['pmbus']
arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dtb: /ahb/apb/video@1e700000: failed to match any schema with compatible: ['aspeed,ast2600-video-engine']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']






