Return-Path: <linux-aspeed+bounces-4635-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E64C55ABF
	for <linux-aspeed@archiver.kernel.org>; Wed,  5 Aug 2026 23:59:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFnSf4KgVz2ygL;
	Thu, 06 Aug 2026 09:59:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785934991;
	cv=none; b=lVyUD/u1LLEgVRhcq/ZHDf5wU0nvmGoS2DGB+CBeVIHUwlXez2z2BNYWYzzxty6xtu759QfAM7+Ym9LXvGj5sqVIqE4v5/5fzhkurXaM2O8qmnSUXvOZsRU1IEJzlniyliWsouVIxz97MjtyLqbLQDW43hu5k7pU3r/zi0tC+rJlWJjBgKk56Ml8P6OJkMeSgRbqmdK28bZkG5GRYl6OxbzdM6ohiWmaPeVX+pKuuWArsKvYn/AVtiAwZYbaGEmKiiksoAyxY3OTvS/WfLaDrv8fFcsRyKIAACyuOddaDyqcPakgkmgbmXvOtEa4bgmpJq5VkHE0YHlNFKirwtTBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785934991; c=relaxed/relaxed;
	bh=u7zVHj/TRLAkAJWBgmWDrJurFpDfEHLobL4LjUc6V+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctUmucjn/BjnO68+n1IHyxBAmuzjdK8piCry8DX6f6F99YnZl7qLJk9KQywjEILAetYT+k3wx0gW/70IxM6u2A2A6giFEDjb9NaEoVKHhgnm2T7pUaTWKXliD17l9LFlz4gOnaM/zdOoOcl+te+gw8hVt61/ZCEzXyOZ+1uiu3cxD6YNwoEkM6JyeXovXfKC3X15RV9oA5XSSk5mgNmOPfE89jtDV7L9f9M/e6GSJU2lB/QXmbkwt5rV8bDyHWsqrqoaLRH5dJwSvaoS4j+6Ud9Rcx4xzdHo+S6ovPZG1Q4G3dib6wjdZzPyo3a6Ph6EwoC4YkID5zXa3dEd0mdmXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qm4SYNsc; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qm4SYNsc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFVvg0jBNz2yMl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 05 Aug 2026 23:03:10 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B8DB43466;
	Wed,  5 Aug 2026 13:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D247EC2BCFA;
	Wed,  5 Aug 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785934988;
	bh=hi9+GeaO3bLXI76yLDOrNGxGs+Avu1qw0k4soBp8eiI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qm4SYNscAty2fhpjlJog1/Rn4io74dZUykcajbdY1oUKhrFeHIDi1fSS0lFP2BCaF
	 zPTdiihSkw3LQ/8OVmeioC9hXKxt1EEsYa7SG7kVBorCDj9TCYV4OMl8ck+burVuCJ
	 8Ve0ccQA8F07FIDOCNDuFInLoUKSMPUvy6p64GtiDtUz+ncBNgNbR4o6HE1az16KFn
	 UQm0jPLG29dROXECE+FZsqo72t+qGwtgulqDv9CqMHYpimW7x2txFvxQIDmJGTdZ09
	 K1yaSVZsZyEIXScj0tLR1ItsEJLDjfX+u54NqN6SpYYsKlKRaMI/uqQi/fJt04F8Gr
	 VWp61Mbwyxyug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B5C55ABF;
	Wed,  5 Aug 2026 13:03:08 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Wed, 05 Aug 2026 21:02:29 +0800
Subject: [PATCH v4 01/12] dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2
 DVT board
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
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-anacapa-devlop-phase-devicetree-v4-1-5d67e0efa6c5@gmail.com>
References: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
In-Reply-To: <20260805-anacapa-devlop-phase-devicetree-v4-0-5d67e0efa6c5@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785934963; l=932;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=ilMNo/yT6oeGDuaZTkvgyuXcAOciPuXW9RaEwTNseF4=;
 b=IjmR4C9MhRHgPVRJbUmaRVvWK6Fm9xWsXUIsegB8uCkYjFtnjuak1hlTKO26h394Pf3l8/3Dt
 ZCm+QUb4/VaCz8vSOW/ih6xrZseYTI/ZqmcQWprg/DvN/cXhCw+rH60
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Document Anacapa BMC EVT1, EVT2, and DVT compatibles.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..1c2656d99807 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -84,6 +84,9 @@ properties:
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
+              - facebook,anacapa-bmc-evt1
+              - facebook,anacapa-bmc-evt2
+              - facebook,anacapa-bmc-dvt
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

-- 
2.34.1



