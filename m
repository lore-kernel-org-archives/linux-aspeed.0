Return-Path: <linux-aspeed+bounces-1388-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BA4C61CE7
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 13:11:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHQzZ2H5tz2yDH;
	Wed, 11 Jun 2025 23:11:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749647514;
	cv=none; b=dwBc0/20QzUsQw0JWzTxyPODhM7RuYCtTRvbULhE8wqSx+lbmTLRokAeqKjLVWi3bHljz2j5gza6UIu1oRLqVhakevt+5OxTiG+6sT6RHvGCo6scchgsDa94C7s/tHK9KQ47MsjeaXfzvD99q1Ucb3o0udls+yXg6Q3Y2tPGeUfhF4DlRpiLCUYswijiPpOffghU0jAJxopsO9lngldZ8Vhjo0lxUpTDOBuEgu7ddAp9WJQg2JLv3Bi+8DAG7YWjnSHQGXuqUmhc+QjHykTqzSOofIsVrLrllFW9rs88i7VNyM8jMh8g3Du8N0GNs3exnd01ox2nBQCVbcCqesV8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749647514; c=relaxed/relaxed;
	bh=2IafO0bbLugSujGK5zlfc688S/34ViKtl13YGJp2mjw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=AtUERrmj3tyD1WhmQCNILTnZO3c4KYtJqtAK+jhNTmkFPt/C1QyQ83hY0XM6zJOW/w1xiLL4RoEgi2eaobUJ8Qs3zNfOzNpAHP0abZpFIItnUejxP/NTB0iVy8ILSMzAYpW8wyoTgElMfHRQykga/RJu9F3pl8IK2C5vMeb93pSU1g+pL43RgRnfCnqgkKk/ADlELjBtB6GWsd2KzdnEHtIPV2ACUAn2WQ57iNzfwCy1etzQGfRiSW+ZtLv1SVl4Fq9SdqJf9AWCIrMQY4aEpQO3ic4bLOHq3q9gwV5AmUGsLmpK4kFTKFXzUrL+kQ6H2ayxz9hFXZEvfOirKnGzkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TkznKi4N; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TkznKi4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHQzX6mswz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 23:11:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D14A9A517C1;
	Wed, 11 Jun 2025 13:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A0DC4CEF0;
	Wed, 11 Jun 2025 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647509;
	bh=17MkG0C8bl6FcCEHcrp0f+2wYA/v8JqJiSHUihbbJUM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=TkznKi4NMMMbKmHu/Mtx6e9UakZtgM1nRXe7YsEu4UaMcz841YocvQ3hTkogVZQmF
	 7RyPNjSHimH3xjWsT0uZ/xe/z09QbbYngY5nsY6zq5DEi+/jKq593ArSNx2Kr2qcmu
	 n5h3iv25+gDirKuEWq83XqrtPLtEnqWaJt1oxBxUIhFNifuLM0Y33kpw2ABL/GUW4u
	 3BD9VR0AsvDzT/je5EWyQjaAADmE7aBQT/XpeKoO7h8P8qX/mujoFLGqiHGJAUEtgY
	 adkcVpxI3lgsb7Krt5bL9hjrk3dwwb9mDUwuPlF3MkpfpaxaUoHm5ZAjU8wWGQXqfC
	 3WSQT9AG092QA==
Date: Wed, 11 Jun 2025 08:11:48 -0500
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
Precedence: list
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jerry.lin@quantatw.com, yang.chen@quantatw.com, conor+dt@kernel.org, 
 patrick@stwcx.xyz, joel@jms.id.au, linux-kernel@vger.kernel.org, 
 andrew@codeconstruct.com.au, linux-arm-kernel@lists.infradead.org, 
 krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org
To: Jason Hsu <jasonhell19@gmail.com>
In-Reply-To: <20250611112650.595554-1-jasonhell19@gmail.com>
References: <20250611112650.595554-1-jasonhell19@gmail.com>
Message-Id: <174964724537.330081.15600848712697673858.robh@kernel.org>
Subject: Re: [PATCH v8 0/2] Add Meta(Facebook) Ventura BMC(AST2600)


On Wed, 11 Jun 2025 19:26:48 +0800, Jason Hsu wrote:
> Add Linux device tree entry related to Meta(Facebook) Ventura specific
> devices connected to BMC(AST2600) SoC.
> 
> ---
> v1:
>     1. Create ventura dts file.
>     2. Add commit msg.
>     3. Use format-patch to generate patch.
>     4. Add subject prefixes matching the subsystem.
> ---
> v2:
>     1. Modify email content.
> ---
> v3:
>     1. Add mail list.
> ---
> v4:
>     1. Apply git send-email --thread option.
>     2. Sort nodes in the dts alphanumerically.
> ---
> v5:
>     1. Run scripts/checkpatch.pl and fix reported warnings.
>     2. Remove unnecessary 88E6393X CONFIG FRU.
> ---
> v6:
>     1. Add a new stage for the DTS change.
>     2. Run scripts/checkpatch.pl and fix reported error.
>     3. Fix the issue in a separate patch.
> ---
> v7:
>     1. Fix broken indentation in the device tree file.
>     2. Sort nodes alphabetically, then by address if equal.
>     3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
> ---
> v8:
>     1. This patch series has significant changes compared to
>        previous versions, and quite some time has passed since the last
>        submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
>        tags are not included in this version.
>        If needed, tags can be added again after review of thisnew version.
> ---
> Signed-off-by: Jason Hsu <jasonhell19@gmail.com>
> 
> Jason Hsu (2):
>   dt-bindings: arm: aspeed: add Meta Ventura board
>   ARM: dts: aspeed: ventura: add Meta Ventura BMC
> 
>  .../bindings/arm/aspeed/aspeed.yaml           |    1 +
>  arch/arm/boot/dts/aspeed/Makefile             |    1 +
>  .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1481 +++++++++++++++++
>  3 files changed, 1483 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts
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


This patch series was applied (using b4) to base:
 Base: attempting to guess base-commit...
 Base: failed to guess base

If this is not the correct base, please add 'base-commit' tag
(or use b4 which does this automatically)

New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250611112650.595554-1-jasonhell19@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: timer (arm,armv7-timer): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/timer/arm,arch_timer.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /sdram@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2600-sdram-edac', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: bus@1e600000 (aspeed,ast2600-ahbc): compatible: ['aspeed,ast2600-ahbc', 'syscon'] is too long
	from schema $id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: syscon@1e6e2000 (aspeed,ast2600-scu): 'smp-memram@180' does not match any of the regexes: '^interrupt-controller@[0-9a-f]+$', '^p2a-control@[0-9a-f]+$', '^pinctrl(@[0-9a-f]+)?$', '^pinctrl-[0-9]+$', '^silicon-id@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed,ast2x00-scu.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e0000/syscon@1e6e2000/smp-memram@180: failed to match any schema with compatible: ['aspeed,ast2600-smpmem']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e6e0000/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2600-gfx', 'syscon']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9000 (aspeed,ast2600-adc0): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: adc@1e6e9100 (aspeed,ast2600-adc1): 'interrupts' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/iio/adc/aspeed,ast2600-adc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: crypto@1e6fa000 (aspeed,ast2600-acry): 'aspeed,ahbc' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/crypto/aspeed,ast2600-acry.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740100:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: sdc@1e740000 (aspeed,ast2600-sd-controller): sdhci@1e740200:compatible: ['aspeed,ast2600-sdhci', 'sdhci'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/aspeed,sdhci.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/sdc@1e740000/sdhci@1e740100: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/sdc@1e740000/sdhci@1e740200: failed to match any schema with compatible: ['aspeed,ast2600-sdhci', 'sdhci']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e780000/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2600-timer']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: lpc@1e789000 (aspeed,ast2600-lpc-v2): lpc-snoop@80: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e780000/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2600-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e780000/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2600-ibt-bmc']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: i2c@400 (aspeed,ast2600-i2c-bus): Unevaluated properties are not allowed ('aspeed,hw-timeout-ms' was unexpected)
	from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b000 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e790000/fsi@1e79b000: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: fsi@1e79b100 (aspeed,ast2600-fsi-master): compatible: ['aspeed,ast2600-fsi-master', 'fsi-master'] is too long
	from schema $id: http://devicetree.org/schemas/fsi/aspeed,ast2600-fsi-master.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e790000/fsi@1e79b100: failed to match any schema with compatible: ['aspeed,ast2600-fsi-master', 'fsi-master']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dtb: /ahb/apb@1e790000/dma-controller@1e79e000: failed to match any schema with compatible: ['aspeed,ast2600-udma']






