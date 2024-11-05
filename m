Return-Path: <linux-aspeed+bounces-77-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CA9D1CA0E
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 00:33:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xj8TF2JDkz2y71;
	Tue,  5 Nov 2024 11:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730766817;
	cv=none; b=c1rGeKvZVvwRZF+bFH1EFwGoE9UohqsdwySrX05FmaCyFPMzMe+trED4gazp9y/29kbdz6SOuOxcskFenFGlDxAtBQV6Wdn8T4/mVhQKOrKYF91RTxYbBl+t1c12ubrUpLFIYgJE5YWvZ2MGxL+wJV/DomHpuqaewocvRBr/msC+pDyenszP3z3hH6ANJThCR6hkbypG5x85KMELwhu9rNmt0KemzDMLa1u57hTkI1rPajSwvg4uGg51rl+beLWAtp83wAwoT3gi7sT8oQ5auDLRJZ0qQiLWlo4CozOeEnly7Y9Eg3qVMlZzMsGbBtaodH27Jn9ISfyIObTBERIAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730766817; c=relaxed/relaxed;
	bh=36wSJdCPKTJa+pneI4xqY1eNvL6gR9xuN9Id9gxbFnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvzscJvxiB3K21ZqefhxeC+N4hIF7lew4MUomKWoJfy7lzbyjz0Xla6wOuXV6JRW0muLGLHwG/bsUyoDw1XhgtRtnh2BtMsKUsbeikpPW+Tz6obXJS+ebhpuoUv7qzRm2NPGkvnHOCWaPiLH7Mn1RxrkvqM4wPqXenZQEwYMHAs9AY5MrqUdr+Arj9Sqt7Vcb4TISzjInbg2H16Sj08pXFzuOjkRm2oRlIX0n5LIpDnTVZNJb6Nlbt9HmBIdxHVdKlpL3oz8e+kCMJ7ob9oRqBm6URpKLz/+swN+zDKvvI+AfLLxu0P5S9aNLY1CRW4l5o7NDc3pSWHDNQhz1cJNng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AUDsRB1/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AUDsRB1/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xj8TD1JJFz2xgQ
	for <linux-aspeed@lists.ozlabs.org>; Tue,  5 Nov 2024 11:33:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730766815;
	bh=36wSJdCPKTJa+pneI4xqY1eNvL6gR9xuN9Id9gxbFnc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AUDsRB1/SnWNB05Bh7/nXGANt9HOyTC6CQhGs8nEgXGa1rUwo0qEPyvmc8gOAoc0h
	 iulp1MUJmq6WiYAzHE6LsjtkahYFQbdR3vb5D9OrvO8QnC3evjwpobiyBn7bXitSA5
	 8fTeFXStcGYX3vVGCtCBxq/c2dKsIYZIu1uqFN0zsVltNbKoemWYO5ulZSPLwzuubg
	 RQWZSFfCV25ewjc7FSFTJLeTwxcblA6jN019R1UdCDc4EjCIgetPkR8KG24+VM1gMz
	 11JHb8ZQLgXcrXo2SmiXZ59HBUuw01CwxNKMlHQ3qEk22A63hfzrdTMPt97sTWreMJ
	 dWajekN8ALT1g==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 38B436A3C9;
	Tue,  5 Nov 2024 08:33:34 +0800 (AWST)
Message-ID: <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Naresh Solanki <naresh.solanki@9elements.com>, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
 sylv@sylv.io,  linux-hwmon@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Date: Tue, 05 Nov 2024 11:03:33 +1030
In-Reply-To: <20241104092220.2268805-2-naresh.solanki@9elements.com>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
	 <20241104092220.2268805-2-naresh.solanki@9elements.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mon, 2024-11-04 at 14:52 +0530, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Add a device tree for IBM sbp1 BMC board which is based on AST2600
> SOC.
>=20
> sbp1 baseboard has:
> - support for up to four Sapphire Rapids sockets having 16 DIMMS
> each.
> =C2=A0 - 240 core/480 threads at maximum
> - 32x CPU PCIe slots
> - 2x M.2 PCH PCIe slots
> - Dual 200Gbit/s NIC
> - SPI TPM
>=20
> Added the following:
> - Indication LEDs
> - I2C mux & GPIO controller, pin assignments,
> - Thermister,
> - Voltage regulator
> - EEPROM/VPD
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>=20
> ---
> Changes in V6:
> - Verified all regulators warning resolved.

How did you verify this? Testing the patches locally, I see:

   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu2@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu2@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu1@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu1@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu3@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu3@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: regulator@5f: 'regulators' does not mat=
ch any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: pvccinfaon-pvccfa-cpu0@58: 'regulators'=
 does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#
   +/home/andrew/src/kernel.org/linux/origin/build.aspeed_g5/arch/arm/boot/=
dts/aspeed/aspeed-bmc-ibm-sbp1.dtb: mp2973-pvccin-pvccfa-cpu0@58: 'regulato=
rs' does not match any of the regexes: 'pinctrl-[0-9]+'
   +       from schema $id: http://devicetree.org/schemas/trivial-devices.y=
aml#

From a spot check, the warnings seem legitimate. Did you send the right
patches?

Andrew

