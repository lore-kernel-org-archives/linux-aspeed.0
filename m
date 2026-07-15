Return-Path: <linux-aspeed+bounces-4487-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E0FC44501
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jul 2026 14:31:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0dsL2h08z2yll;
	Thu, 16 Jul 2026 00:31:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784125894;
	cv=none; b=kpHGLAsNnEROBN6FgwjJvR6hmegZwrQ7hXnYd/yYRQkSZ8XdPFFx6KKHs1Ktny64Ag1qbl6zGqBOytsfsoh4oE6yTsweeMxSRhm15xfZLOZohBnyTgQQ3Bx43jwQpHPUvW7IQjxjXp5bgL7Dhn3F156rW5qhALRc1X2zgSqoBoONAviD/TUGaYBDSlKBlT98RkhvoQqrgVBPhU4igUEDzz+cCka/wsuw53Oi8OYrimdeEBl1RmFX2sVpQKesXSi/QxpXq7peiOUUI3x9Qukv7OOV760r8BIusZHGYDxOFI6xejGEHL5rpPmc+fVLgxfEkj7KszUu8LeouFrwshDpBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784125894; c=relaxed/relaxed;
	bh=/PBmppuhCNxseIU2k0JL0kCPG9sQNuCzK5Mbh3VeYEY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Se3C1QXiJAzm2z1872LVjJk/1hmD2K1bK1wCKJ4DtmBVCjzEtFb3VJevXQou06DByEDOvErGjDQsVjyh9qu9PhjtaJzJldiVsT08JGcBLcMFVeBZIfm3YP3FZ22rJ3SdBBVMEpf0bQayI6mH5irSETbU5vVbsVmF7ITXkWPKycLO8I0PHHxlkF1jnfiwPzmODeLNzo/isx6Qb0FiMz/qwRfFBj2im3XtSUktA1OSqnvJ+phLajFCOH03FnJO5uYSJAeYIKaOjNi+V/I/j9Yg8fir3nbQ/ltoubDrFk1doFNaj1IOinanhNpj0C1AbFVP/MGEdtbu2dLswsxqxj5FIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=UNxV/beX; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=UNxV/beX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0dsJ0x0pz2yl0
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Jul 2026 00:31:30 +1000 (AEST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-493c19bad03so49353155e9.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jul 2026 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784125888; x=1784730688; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/PBmppuhCNxseIU2k0JL0kCPG9sQNuCzK5Mbh3VeYEY=;
        b=UNxV/beXtCW/mHIBJ7cf/92PiY2W9qBO5ry4/PhZrjXWFNjuOtOj/O6JkSM8kxQj09
         18xc/8ETOs06YedZLS2NVeIj/Efw0bBqFHkVjqz6oTYjMasUModLdqoG+A8hTlUT+1wg
         MydUtz7lun5LL5cH3K+aTWcvygbaUPLZwHJXXoFua2LALKdOZTCvz4ODfcR9d2yOjw5n
         /tG71+ZLycGz5YtelEN2FGazJdCy+7Dqg+BYoUhnNis3sXsO4dn49aOFhlm9ZqgaOW7W
         7XsJAQ6wgKF1nhI5nq3e10AEgDg28hIc9CeHjCffs7cJIPO14yn2rVvFJ48ZL0q1v0wE
         LRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784125888; x=1784730688;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/PBmppuhCNxseIU2k0JL0kCPG9sQNuCzK5Mbh3VeYEY=;
        b=H57st0mXIO52wkOr6DIn30ERwOsIscI+oxumXYGxlXeaKTSBbNKKVmxLLI+r+G2UQQ
         0/CoGiOWsxTJjyDIsjwUfCz+YrMFxx00mmyS6ge0zBr+78P76rxn0pSKUTTxEXW8aF6H
         e+dNZDhgoLXDYCxeTy9p1uj8QsH/lxPwdEA7g7zRKxjogfD0Teqkz0ljXKzMMUY2hMxU
         XZVdE8gKzsNRzypbkKY/onJ71yNnc1sLbC86YkwnOlQwp9lLqPXJOv7IZGvQK2Zo8ZLY
         FmQk6Ph8p4DhksxAOgIoWn1BmAv8YBFUnQ+Jp7eUaekRzaq4j894gdC+9Ec+vExkIJ2d
         yeuA==
X-Forwarded-Encrypted: i=1; AHgh+RpYecyh+3N7Ow4ANUruZo3eEU8QaJrhcPMeNec14ZzEcbNmr4PsflXChFw7vClqIDW9ZFm+xRlVf34/T2g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzw0kAY3mrjSeHjDv7RZHJHJTF/RCQpM5FoycDBVJDzXRbXpoPY
	RtBz5IavJ3dXeXAPt+wD3yOhxuIzYkhD8jCT/3Xq7x2Te1U+aNdPJnTTB8eGjqUVLyY=
X-Gm-Gg: AfdE7cl9J0+EiwMGzb0Q4QBaQ8yo0MNeShHE/TaC5PxJSZaPFLxcDSAfMFlH41mRlu3
	D59yBqPDsaditwHrzgX7cdajk1eH5oN98yxEvbVEhwoQbbQcUryr9y3bsrpn356vkTUwqcJNe2y
	EaoPXPjG9aBpLYI3k3tWBdyGjjJVcgsucJCUQhe542xPOx5qOeVizHkL7D5QMw6RuuaZBJ7H8mC
	X8TOnKjE3dGFX8n1m3suPkvbBRMSGfQbRXFGMPooVPXOiyiysdFtDR1rlEdaXPVC2QNLERcB57N
	envyDbG5jAfILhXEK77asPay11thxDokNMJRBAwPwWmZtmvAD9ypPOlBoSQsAcXYcrc7czTp5nD
	uwV0VSn3XkEyMy31kbjoNPuvfWaBhqz2Hp4oTjW/s6N6vGimAljfUhDd0yE4koCj9o43jHlPd4M
	AgVvaq+twCIlhoQGDeajrIHalkrmvYLrTSBhcqHRJoduDZyPcg21xn+sACfWm1HtlGSieYFpbQY
	x0TF1K6ixw8fq8H
X-Received: by 2002:a05:600c:8115:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4953c14f78dmr32474645e9.2.1784125887641;
        Wed, 15 Jul 2026 07:31:27 -0700 (PDT)
Received: from [192.168.2.28] (p200300cb8704a900f059545e4a985631.dip0.t-ipconnect.de. [2003:cb:8704:a900:f059:545e:4a98:5631])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm280236385e9.7.2026.07.15.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:31:27 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ARM: dts: aspeed-g6: add pcie-lpc and pcie-kcs4
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
References: <de49f2032f5b1f170161dcd6191c0daa48f0b0c2.1784117715.git.gregoire.layet@9elements.com>
Date: Wed, 15 Jul 2026 16:31:23 +0200
Message-Id: <178412588365.243141.16731478852761544781.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784125887; l=1599;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=JBebJb4jcuu7x0vRBxHn+90SiQlNqxWidAhC89Jq7t8=;
 b=2EvNZFMIlLmhR89ccAd8ZS4HjM7x2BcXOqQidZyE+xoKd8+yYA0umsKD0IHfhb6FFnA6BrCOH
 UvXNmryk/sVD5AzueTiADnnFB+O/J1ykpDm5t7mVugXdP7qpI2GTpYn
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add pcie_lpc node and pcie_kcs4 child to the ast2600 g6 common dtsi.
> 
> The ASPEED AST2600 has a PCIe to LPC controller. It includes a KCS
> interface on channel 4. This is a fully KCS-compatible interface
> that is exposed over PCIe.
> 
> This can be used by the host for IPMI when the PCIe BMC Device is
> activated.
> 
> While the datasheet provides interrupt numbers for KCS channels 1, 2,
> 3 and 4 over PCI, not all 4 are described in the "PCIe to LPC Controller"
> section. Since only the KCS channel 4 is described, only this channel is
> added.
> 
> Ordered next to existing lpc node for address ordering.
> Use existing "aspeed,ast2600-lpc-v2" compatible string.
> The pcie_kcs4 uses existing "aspeed,ast2600-kcs-bmc" compatible as it's a
> standard KCS interface.
> 
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 56bb3b0444f7..ac351f01048f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -658,6 +658,21 @@ ibt: ibt@140 {
>  				};
>  			};
>  
> +			pcie_lpc: pcie-lpc@1e789800 {

lpc@1e789000 already maps 0x1e789000-0x1e78a000 and 0x1e789914 falls inside it,
so you're describing a second `ast2600-lpc-v2` node which is unnecessary.

Suggestion: Merge pcie_kcs4 into lpc@1e789000 and use 914 as offset. That way
you don't accidentally cause an overlap for the devices if you describe more in
the future.

	Tan

-- 
Tan Siewert <tan.siewert@9elements.com>

