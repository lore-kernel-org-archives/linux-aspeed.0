Return-Path: <linux-aspeed+bounces-4911-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708FBC61DD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Sep 2026 00:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZNN50sPqz2y71;
	Wed, 02 Sep 2026 10:07:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788264947;
	cv=none; b=aVZwpLPpjisiS+eqOrwNaSTxivXLK3qG4KY0BNvmpntdcPacLJVnzsJEo7yNyImZ05iqSIZRynWyF+b1+IRxNnK0AEAl4DrzlzlFOvUWdLKcoynIWZ7l0kckjgUBVAaRn98i7pzTb5auXCTgE8MwdIAjfCDHztyAwk4Wf1UPrDbs/ZuiWTKpODKdlDGb7urdWV16dP6bmG8ezUrHxZGUEqVT4cVGVLW9mUBZiAbRCZWvCSnACgOFTKceJHiRCCvRt7m9k9PhlY+GkpOZChFd21qNGIEJSYASqPBjtHcWnkWb/GEpoaGf58vSxJYXP3INa/p+6d9y6dM0N9ioT9IT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788264947; c=relaxed/relaxed;
	bh=RolCqDmvzE5wfXa4kjH8rrauyQzL+1hF+sbIJKDHyiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IybXBhqEiF9YCg0lFapUL+fHDrcCwDwmWeQropZr26KzU+/jgXocMZT765UL1ug1Yf0OO94BljHnDgtEmPZz+OMpY3rucP8l+80OS0CGezzU9hDR8zxs9AlB/uqmW9PqES3oHzIi8lQ62wh5ARu3d8exXjFvrSwdymyXbAHHtUbFVoj7uehXdWX+dJNbSRAJQwerjLf3dUjO3dZ6QM/4oPBcFHIreFiz0TFQXEJ3oc6yvDWmzbf377SMrAEAlj9Md6BQL4GA0fW9ZAUom1GdvJkDAy/VI+miJpp03U9IBz3L+g2R3iAGHATOq5XSEoGJXZAvm2KFq3YsILD+rZ7nFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PU/e26RE; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PU/e26RE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZ4ZV0Yvlz2xlv
	for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 22:15:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1EF3B60A62;
	Tue,  1 Sep 2026 12:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC8F6C4AF0F;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788264942;
	bh=6s6cTO6Yn6yN3vSCDT7z8LoUbh5iLlboNe1Uq+mkWZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PU/e26REpqh8GV+fS7q+cbJhyj4/T0khUKuNpb2uFxn8sLXsif/zn3BrM3AjEn5HT
	 ayiqziLHDWQNEld+6GzDjPMU4Itjxn+du76foygg+w/OKGtO9NruL4CDRjWAdhSOaq
	 6SjBcHVG4tCjqUpHiqRSA+D5bqVHpvzLpqh2BlpyS/9z9Ky49kiSAVN4ZOt2VDBVjy
	 pPpPHlVkijt6bjRP9z9SRbHhyQDYG7lGu66A1N3dBi+mZxgzG04bKwz41GUGlALtbp
	 KKPlEDPmGD8NOFbRLZXr2SHQh3sznXe/+feIc4+8d3KWbj1KZeQzFS8YeUxhvvm3e9
	 fOEYt87aRONHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA313C624D2;
	Tue,  1 Sep 2026 12:15:42 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Tue, 01 Sep 2026 20:15:20 +0800
Subject: [PATCH v7 05/11] ARM: dts: aspeed: anacapa: Add eeprom device node
 for NFC adaptor board
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
Message-Id: <20260901-anacapa-devlop-phase-devicetree-v7-5-0bd71d2e0105@gmail.com>
References: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
In-Reply-To: <20260901-anacapa-devlop-phase-devicetree-v7-0-0bd71d2e0105@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Carl Lee <carl.lee@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788264931; l=833;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=26fq2T2FsHohRgFb+8YUKBwoq82KVZ3EC93yHvrPJAI=;
 b=yNkBMl4M29kDge5+o3YGAzEKsBkwqW5oKMeb0jK6wxscwfH9GRuDHhX8Bvo639x3wzQYaVPWP
 rKj12fgNdetCGs8iuZfHoK4PtEvj19Qi4YgKS+G2/HDjj+fwf9fPqgc
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Carl Lee <carl.lee@amd.com>

Add eeprom device node for NFC adaptor board FRU.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi   | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
index 77126418a702..ed46a53aab24 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dtsi
@@ -17,6 +17,19 @@ eeprom@51 {
 	};
 };
 
+// MB
+&i2c13 {
+	i2c-mux@70 {
+		i2c@7 {
+			// NFC adaptor board FRU
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
+		};
+	};
+};
+
 &sgpiom0 {
 	gpio-line-names =
 	/*in - out */

-- 
2.34.1



