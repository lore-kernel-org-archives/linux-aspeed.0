Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8269606A32D
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIEE0s4d
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKMvM220Rz2xNC;
	Wed, 04 Nov 2026 22:01:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793790095;
	cv=none; b=LKOIjMNymjBe8vRDIejc2ofiRlW2wnTR+JlGZcGmkTLbWeNcsJEuJf27Bh3I5CKy2Hctcid+drQhichRfekR87NkG75CDh+SQpFdTzWKqOuCjMwfNBjkN7bEDOvJb1eHwRG0Ntt848Blsjhmnvt3i6VIemoDSLgZtXzGBamFpxF9wpiOTydnJaAWmUyoCj5V0VPzWU68iKHwyx0KmZWhrnfSOgQ/JAsgO/a15vZQmaY09imSej0vcKZDcujTURHYEATIuvvI9t3Z/f3mgohsrd9QDyx7mdeicmppeHQmLv/hF0Rjma9jIxKzvmV9EPXpWyfvtvpkh2ud9IbAxT/EOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793790095; c=relaxed/relaxed;
	bh=685pY4H9qeBM1wsywJSdzE2w1qA5QP83iyiCyy8GEUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Nkffo5euwkoc2g9g8iH+5DSXi7Rr6FpSlcDjVHlQl3ZAHGxIMJCO9CmLb0dRgJCYS0wfsETGns7v5HO+YlprS6HXomHYtM1upUkjzUBUEZ5SGjZQ/344COqP5lBOup2pblL2UOZjEvADGy7yekgAceMrTVlUbIjNV/3gfSqavRFG1GNsSCeM1CuDLgsVYsV6wSgecCckFjvuBzejRfaBmtysyJ6wDt6VA9w3ojjOtO8Kt0pihu043Ih+DJGM4UStvBocoatFDXK+FW7kI1T7s3t+CiZfOKI86gtnKD67RrqxZTc9mbWn6zRP0x0VQ7zI8nPXbrdFn4f0RRXDF7TUQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIEE0s4d; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIEE0s4d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKMvL3N1Bz2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 22:01:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F2746021C;
	Wed,  4 Nov 2026 11:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BF21F000C1;
	Wed,  4 Nov 2026 11:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793790091;
	bh=685pY4H9qeBM1wsywJSdzE2w1qA5QP83iyiCyy8GEUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QIEE0s4dQNvXBJ0e0z9j6+5yUE6LsVEmsJUBcZ3/GNkTDRP4OTjN55dyfC+E8lOIB
	 fDyAYLPlCRUVqozkfsh56w5mJV3zWWeDs8GpqvN7pIaOXyGqS+e/hPHBp32ZnVC7Yj
	 VPqFRZNZh2dXU4MVflvk2B8Cshw9PCt3b8LroYmMZ80ZJrzyspPnoUMvZEFVraJYEW
	 SQi2K5rwsGMzTyKLB77Fg2R3nE+zCYmYid0KdH1RHF59sguLWU7e1yto7qhA4FnNDP
	 kAkfW5QC0kzcetTxZdWpEIFPmGJorS0xWULu+dpHDFjxdCV6tqD+6+PH2LFahkoxxA
	 dqEA+4W8fZ9/A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Dawid Glazik <dawid.glazik@linux.intel.com>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20261104113206.3243865-1-dawid.glazik@linux.intel.com>
References: <20261104113206.3243865-1-dawid.glazik@linux.intel.com>
Subject: Re: (subset) [RESEND] dt-bindings: mfd: syscon: add
 aspeed,ast2600-i3c-global compatible
Message-Id: <179379008960.1643299.8613980903865635886.b4-ty@b4>
Date: Wed, 04 Nov 2026 11:01:29 +0000
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 12:32:06 +0100, Dawid Glazik wrote:
> Add aspeed,ast2600-i3c-global to the syscon binding compatible list to
> document the AST2600 I3C global register syscon node, which is already
> used in aspeed-g6.dtsi.
> 
> Without it, dtbs_check reports this node as failing to match any schema
> on every AST2600-based board.
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: syscon: add aspeed,ast2600-i3c-global compatible
      commit: f0508479c70d9b6f2c3b859e90f710ec5f2f4d9f

--
Lee Jones [李琼斯]


