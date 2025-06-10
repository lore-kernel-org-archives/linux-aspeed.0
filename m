Return-Path: <linux-aspeed+bounces-1333-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D849AC5B552
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Jun 2025 02:31:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bGXpf3pp4z2xHT;
	Tue, 10 Jun 2025 12:31:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749522666;
	cv=none; b=PuHCWddizWR0Olg5h+nObnfg26cJr286J+NXVqF+upmIlbC7cV741/1p5wViepHHbBvvzMn6p2k9UQht76hGWeskWkCfwZEAHcyskfVryvyr3somxY38YhoXI5Z/+6+yu9BX4qj/LenH13SH1EHQxiUwuWCJZG/gQ7CC0rBX5ZKOGGuCjNYfzqR6DG0j3tn4YflJDW7KEohHyWuKVB9Q7GsQ0NkF/S1GFYWKp0/lIrMevysD2qTaWXN7SOeK7LShjQ9Sw0/CLu6VrSh6uYUuGuq8hab/yZEA905ssYLCytfb4r/rPlZIgW0hkVjp6aOUo5S/lagYZ6VtyaPx3NGWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749522666; c=relaxed/relaxed;
	bh=qxT6Nt1Q04hkagtvfdHeoGmiPJWJ7RAPJ/r0KBiCRq0=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kPTdd5CvmL+CryvJ0AGTXXZLTF7Tp3dfgXBZknltH6exw1oOIPJgW3MINJ1dCZ1Eo7svoSiTYDoESsGCpVerzfTH52h/3PWX4xlTx97odaHq2MzjXUbFV5HUGBs/ln87QCfNxy3bUUQMGKAqm+XQ9holE6QBzhzVRIpAdjcjFwu6rJwonjkzzuEMXfurfXe6rMTMAfFxwRHHJsvML5QQEng0vzVs9emGOl660nZ2EL8HJue+i25jQz68E6dBDC7fNDAITDBosHqAajQp2ckFs5gEPVcjT2YQVVGxcX/6jIH4C5UDpHu5tT4UsbetEdPZLlxi8w0tj5wu4lQoypSqXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QtPCtTdA; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QtPCtTdA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bGXpZ1Sqwz2xGv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Jun 2025 12:31:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A06A6614E0;
	Tue, 10 Jun 2025 02:30:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B1BC4CEEB;
	Tue, 10 Jun 2025 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749522659;
	bh=MF9eFED5nRvQBjnkQkaYBoOXrlZbPXE3oEhI6hM3hIM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QtPCtTdAWiYNrWfnLL1Egie323Tgg630GTtlhtKZVSX9uBqa1Gr88E9RsbxDT91td
	 g8N2E1mXP6KQ3i2S6j5SfrRj0MaXKnbtvuE83BlJUxGGpTiVbnl2rxiJMDCs4KEyTx
	 8GoA9PljkQes7HFBNnlOgpA+P9Osn1lcp/7BumzmdOTDsooqKlOoMYKrU0N+NtBleL
	 XDFNcpnclJnjOq5Ft8al8OYLgep4MJTJBH3B1r74QqveEOOgVHBzBa3R7cBj3KbHtg
	 aOW4kofCS51lkO8XkZR1GLTWMCjnZ4wICUfyW4BwQFGxs5B6ZFfvE6OYVB/idqhdt2
	 m/aI3IhosKoyA==
Date: Mon, 09 Jun 2025 21:30:57 -0500
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
Cc: edumazet@google.com, netdev@vger.kernel.org, 
 linux-aspeed@lists.ozlabs.org, mturquette@baylibre.com, 
 BMC-SW@aspeedtech.com, linux-kernel@vger.kernel.org, kuba@kernel.org, 
 krzk+dt@kernel.org, p.zabel@pengutronix.de, sboyd@kernel.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 davem@davemloft.net, conor+dt@kernel.org, joel@jms.id.au, 
 andrew+netdev@lunn.ch, devicetree@vger.kernel.org, pabeni@redhat.com, 
 andrew@codeconstruct.com.au
To: Jacky Chou <jacky_chou@aspeedtech.com>
In-Reply-To: <20250610012406.3703769-2-jacky_chou@aspeedtech.com>
References: <20250610012406.3703769-1-jacky_chou@aspeedtech.com>
 <20250610012406.3703769-2-jacky_chou@aspeedtech.com>
Message-Id: <174952265793.3644019.286629373000016480.robh@kernel.org>
Subject: Re: [net-next v2 1/4] dt-bindings: net: ftgmac100: Add resets
 property


On Tue, 10 Jun 2025 09:24:03 +0800, Jacky Chou wrote:
> Add optional resets property for Aspeed SoCs to reset the MAC and
> RGMII/RMII.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/net/faraday,ftgmac100.yaml       | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: [error] duplication of key "allOf" in mapping (key-duplicates)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml: ignoring, error parsing file
./Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/faraday,ftgmac100.example.dts'
Documentation/devicetree/bindings/net/faraday,ftgmac100.yaml:82:1: found duplicate key "allOf" with value "[]" (original value: "[]")
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/faraday,ftgmac100.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1519: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250610012406.3703769-2-jacky_chou@aspeedtech.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


