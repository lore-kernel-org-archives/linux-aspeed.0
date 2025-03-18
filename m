Return-Path: <linux-aspeed+bounces-1044-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1B9C282EC
	for <linux-aspeed@archiver.kernel.org>; Tue, 18 Mar 2025 17:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHJF80BvKz2ySd;
	Wed, 19 Mar 2025 04:07:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742317675;
	cv=none; b=Bk73VSBt426Js1g6lqogN3dKYfixLUyXQUKE44w/sIO5Ai3hyHNLcR8RzNCIHZUrm1pC6AIrWehznaYbqYQM6Gxux14ixnpXMDjKAlftS94nDabYJi77jWUFsISiYsa5+em5A5cQkr2WSs7cGSBY6FiH6fbr+jXrBw6cypQMKh8ocf6jgjinLttbLKl8FrAMTR/hgfYl18x4nNPfSwXkbxnQXVl1x1Ul7sWCpnPGYx7puwaFM9LwqIckyRzvwKqEZ8aalx/8pa3+dqyvNhq5haMqIz2AM+noRen27VeOEq5eCLPJZhduYMw9On3Qw0VCVPZDxzbtXgYpNSXal+cXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742317675; c=relaxed/relaxed;
	bh=Rv2cgmWeDpgTRXs3pcSTXnSyFEBSkNMNxViatRStrqI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=g097gy/KNbCW9YTtJP8FSDBKva5ZduU7lcVlgbCVDFcBX0Ua1QPX7q2vtnKfHmAo2xuhhyTUfa/+PeZwgnBGj59AigJIn3jzWoYO3djA2VxEYugGDhjewgxxPi9r165DKR9XVKuRPSW/V2AaQHb8FfCB9fH+uWCePND1Js5UtwIz2Zjv4PX1jqnPkBHpub2RZmbnnP2YpTwvpAOLir7ggXBnehAqb4rccpRj8O3iv430PEpyOSLdcHHUz94mtWdmUDtLA8UyQR0PKS8A3/pU9qqIa1qZCEB5MnM+vu8da4CFjpcOPRoQ3IFiGVSqQqS8rsNfaCrlwhQWDYJU6YCsfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m8DO/VWd; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m8DO/VWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHJF712Jyz2yMF;
	Wed, 19 Mar 2025 04:07:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E61E65C58DA;
	Tue, 18 Mar 2025 17:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501DEC4CEDD;
	Tue, 18 Mar 2025 17:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742317672;
	bh=ClveRfCHzxpsa3h6WnfKVB/u2POf/KIKNL1rIjfPHD8=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=m8DO/VWdfaesHQ5jT69BoVvNtsn228iyk8FyWouLmx6BqE6Dpf/ZmT1F1QIOMLXMd
	 5wHGTGrwLlL62BrnRxM3tyc1SMiNPxET5U7HXjKMXeUxeiwCwbHDvGv0Ain3bm99az
	 ETpLdjwARCwR+E5xDYcZmNIlaruV5mCCQxPh8UJWKs/ZuYS2jDMP7UZ4HOeR5X/j+P
	 DhMKJhomyUxcf06pTekpfMFAkQ1oT+zwKJbyJG1Sy1oLJH7vBg/hlhau2HnZQumt4X
	 mSULDDO4k6SBxHXpjSLzbtWvejh8jDR5DQ7xoR30zsKURxg3nIwOGx6tA7w2r5rXkG
	 /vB3aDvmpWhpw==
Date: Tue, 18 Mar 2025 12:07:51 -0500
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: linux-aspeed@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 devicetree@vger.kernel.org, joel@jms.id.au, conor+dt@kernel.org, 
 robh+dt@kernel.org
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
In-Reply-To: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
References: <20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com>
Message-Id: <174231753965.3228114.9624277631612711787.robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC
 compatible


On Mon, 17 Mar 2025 23:12:23 -0500, Rajaganesh Rathinasabapathi wrote:
> Document new AMD Onyx BMC board compatibles
> 
> Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/aspeed/' for 20250318041224.1693323-1-Rajaganesh.Rathinasabapathi@amd.com:

Error: arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dts:20.25-31 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.dtbs:131: arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb] Error 1
make[2]: *** [scripts/Makefile.build:461: arch/arm/boot/dts/aspeed] Error 2
make[2]: Target 'arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1475: aspeed/aspeed-bmc-amd-onyx.dtb] Error 2
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb: /ahb/apb@1e780000/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
make: *** [Makefile:248: __sub-make] Error 2
make: Target 'aspeed/aspeed-bmc-microsoft-olympus.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-delta-ahe50dc.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-palmetto.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-ast2500-evb.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-quanta-s6q.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-romulus.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-sbp1.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-inspur-fp5280g2.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-minipack.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-mowgli.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-witherspoon.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-vegman-sx20.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-tacoma.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-lanyang.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-vegman-rx20.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-fuji.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-everest.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-bytedance-g220a.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-cmm.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-blueridge-4u.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asrock-e3c246d4i.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-ast2600-evb-a1.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-amd-onyx.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-supermicro-x11spi.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-vegman-n110.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-vesnin.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-bletchley.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-ast2600-evb.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-inventec-transformers.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-rainier.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-tyan-s8036.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ampere-mtjade.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asrock-x570d4u.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-yosemite4.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-blueridge.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asrock-spc621d8hm3.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-inventec-starscream.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-rainier-1s4u.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-yamp.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-rainier-4u.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-catalina.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-amd-ethanolx.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-bonnell.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-inspur-on5263m5.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ampere-mtjefferson.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asus-x4tf.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-nicole.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-intel-s2600wf.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-wedge40.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-lenovo-hr855xg2.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asrock-e3c256d4i.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-lenovo-hr630.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-asrock-romed8hm3.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-quanta-q71l.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-tyan-s7106.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-yosemitev2.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-wedge100.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-elbert.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-amd-daytonax.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-qcom-dc-scm-v1.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ufispace-ncplite.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-opp-zaius.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-portwell-neptune.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ampere-mtmitchell.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-fuji.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-minerva.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-galaxy100.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-harma.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-inspur-nf5280m6.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-wedge400.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-arm-stardragon4800-rep2.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-ibm-system1.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-greatlakes.dtb' not remade because of errors.
make: Target 'aspeed/aspeed-bmc-facebook-tiogapass.dtb' not remade because of errors.






