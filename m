Return-Path: <linux-aspeed+bounces-4704-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F510C5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:40:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk0H6Hq2z2yrL;
	Fri, 14 Aug 2026 10:40:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622406;
	cv=none; b=GD/wjd+KqCT8v53mFHVwx3fq18sfhA7i1RIg1arpCZokSIntfukUzFDLr2+JeAdScTJAJJwIo5SDkf3i0dBwJgTNAekL0K3Dfa8uVUI2DfiULXINd3l5CHlj8xi55wtFZW/BWUO9ibo4+B/nmGzY/WlcgoOf2onyTz2JEH8oSuO0mgnQCMAMMqISVDpRleSXXscY2AKQRoE97nCUTLX+4t6xLIyVCnpNHv1mrctMf5TrK3cOOEYgX0i2mUaVuoKN9qj7BxrRoLpwejPiWDADqjwyZZ90jnOP37lzWxLsWh5vDJ+cUNifvUyX1y0yljDBX34CNE8KB5PLMD42ULQrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622406; c=relaxed/relaxed;
	bh=dSCgs0lQLqQsikPfdXK9PGRbuAiA76T18Sx7NNxX49E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqpfF8eHKtkCNDuvAgYxBnsPzp5rMGuw/QM+elpSbe3epSFUs7Py/Puj/nr9Ja4a/soAhcJLfM+PGEvI2l4HyShuryHhUgZsUGWbO9vyTmGorApmCiRAYOsG4+YwrGvIC65UM0+7eBcjEVdkM2PO3EB5kWRX1sc8hIKNpMScvqRNZ4YzM0YRLS4S5MW78zZ8iDi822KUJzgGzGIbAFRRend29bet/hgBHLQvtwAWvKMzybRK16D9xbK71WcqTNfSRobt0Tt1qicURF/EvvfFZjpSwEIrgaBh33ikP8PRHTGZeLZiElSomRS+ufTbrJQhjZUzxBM9weLuAKGpKRasVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UwLk7aUX; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UwLk7aUX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP775Xjrz2ynC
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 388D7600AF;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEFCDC2BCC7;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622399;
	bh=Vj1DHrmGR0tyVO+ZlDxsQgZLtvtVuNtuX+cbxrGaewI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UwLk7aUX6eblDL5+ILVIy7EMM+xYUVYYERWPlhowguzjo3XQYAkSihclHOJ0jBZE8
	 kX/niZlh3Hpj8iVdIQRUfMS1FMjjrNKJ0gPAuqwJfvd7ENbvUdUvd6WvrNoE2jcXWl
	 Nvu9dSI9sHLK457S3hKaK/skYCaUO9yZRMZyWF2LNStIyVNmS3CtWnT2K9lTMv30LK
	 TGKtmkPHakzRIs/vsbKrU1cBFs8fC6IhqLryj5iqVsx07Uoe3PS8PIV8IFtHy9boso
	 S0ny6pXHhpAOIXAKz9DHbb3n0w77C/G//FiWqpZb1+Hx8bL3+F3q0UEMAnJW6bxAsb
	 4JFpZP0t8yr6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAF9C5B572;
	Thu, 13 Aug 2026 11:59:59 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:31 +0800
Subject: [PATCH v5 01/15] dt-bindings: arm: aspeed: Add Anacapa EVT1 EVT2
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-1-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=985;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Sw+OWK3YcWaJDMswc4oOvzoue3GKb6ZepbG6V99kpbc=;
 b=Um55I6CVH1x3FcJbngRYHo3gZ8DbRaJiyMXDx6AbqYHQ6ZCPaaBQ44jhg4oELVPsZ3bXgqO79
 b+i5I3R1XGmDvK44ZrYD92TWtlq0ieC2qjMGWtxiIdrbdXSZPpBZ8Pm
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Colin Huang <u8813345@gmail.com>

Document Anacapa BMC EVT1, EVT2, and DVT compatibles.

Signed-off-by: Colin Huang <u8813345@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..1c1570143bd9 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -84,6 +84,9 @@ properties:
               - asus,ast2600-kommando-ipmi-card
               - asus,x4tf-bmc
               - facebook,anacapa-bmc
+              - facebook,anacapa-bmc-dvt
+              - facebook,anacapa-bmc-evt1
+              - facebook,anacapa-bmc-evt2
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc

-- 
2.34.1



