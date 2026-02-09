Return-Path: <linux-aspeed+bounces-3510-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7315E94620
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Feb 2026 23:11:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f90nR4B5Hz2ydq;
	Tue, 10 Feb 2026 10:11:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770623945;
	cv=none; b=h80jjYBDT4fShfwbAdmIexX7XtlhkX/Uzq7FinmxKRuLtMno77ynHrTk/R6wFX3ofxmAwVP5WNJBxPvy6p+uvBopxcgB/5sM/VcaALtzEhwFu7PWDeQF0iWp2Rv+3eiPmvMDKH6qL+ls3Iq7wLgs87kT18Ahe9Jw1gfWx939wronIXIF1DGdDUzo327557adpkW+VuKjouwh8xHVoMaOnDJFD4JC5raCPS/6UnDTiukX6Ub4Obi/E7EWz8WoIpgbfcCsLXCJdHem9WJ3XJmO78vkiyBkYzjfVZTgUBEWUSNsPAqLyLh1UftgChDEV+B734OW8rQ6LTSGUIQ/3xbedA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770623945; c=relaxed/relaxed;
	bh=z44YXzKmyMtQgvTiaKGbV8un2m5fsA276LfQu7lOjC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UgZ7coEEcc+2S81ppvZ/mcUCcuaQVsiQhQ+vjDMPQm3rMEyXMkCCsVfUhyt5+q1NY4hDw52wkpf628El68pAwICX3o6DiEpNB1aA9vnzBeMH2691xUNzKkYMYOgH2iHifHhc141o2I4r2p2ouThn7Fh4CzWusKkgn4sEuOKeFYFMvvYzKWWrjg0NxXFEoop4TypbkEa3Q5afrQ0iXqYZJBKcF9AtC1guUvF0UCwT+4KSgVQ5E8iLhIDOa6AkDCp2PbROv1jZ33yww3m0tEUslLbYHvAUkHFwf1v37VES8ofyoeCioucb4cSL6Mi1pWiyGYSbkvLHXROV7VMZSL+MhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qZfUOlTn; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qZfUOlTn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8cXS0y52z2xc8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Feb 2026 18:59:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id ACF4540A70;
	Mon,  9 Feb 2026 07:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80C45C116C6;
	Mon,  9 Feb 2026 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770623941;
	bh=EvZLo8yBPuNQ2ZWhWlIOFY5LAjRlRTBuCqsicIyWtNs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qZfUOlTnBdSEk5iVMZaxtqVbSDShf99WcsVyOJB1R3Spo6wkhqwHL1Bp7qYhmRe60
	 nn6V5EVP6IeO0DirysjrtX6BcoxPO6HwUkGm2bVwY1CGiWXjJbI3gJ3ZdoqQkC9oN+
	 StMtBgVJNamevWZ2eDjIjTc46vmKsg45faAF5zyytTndnfZSMvJyJcjwqZXIPLOUN4
	 3b5EpSsEj2AoERT3A6RCyoQbtkTINk7z9PK/jK7JwpcuE3zRoXzxlNQ8NIleOiYO0b
	 g9itA46W4LbnMaSFCtxsojx4dCRLdPALdZbB/ZNi3eira4KQ+4Wnap9WD/RA0V+uLn
	 uaWNy1gjmq5UA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5436AEF0711;
	Mon,  9 Feb 2026 07:59:01 +0000 (UTC)
From: Dirk Chen via B4 Relay <devnull+dirkchen.amd.com@kernel.org>
Date: Mon, 09 Feb 2026 15:58:53 +0800
Subject: [PATCH v2] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
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
Message-Id: <20260209-b4-anacapa-dts-fix-v2-1-fe446a7038bf@amd.com>
X-B4-Tracking: v=1; b=H4sIALyTiWkC/32NOw7CMBBErxJtzSLbmF8q7oFSrH/ERZzIjixQ5
 Luz5AA0I72R5s0GxefoC/TdBtnXWOKcGNShAztSenmMjhmUUBfBgUYjJbK0ELq1YIhvVOIagr/
 TyQgLPFyy53qXPgfmMZZ1zp/9o8pf+1dXJUp2Om2ElPp21g+a3NHOEwyttS/r+y4osgAAAA==
X-Change-ID: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Dirk Chen <dirkchen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770623940; l=1517;
 i=dirkchen@amd.com; s=20260202; h=from:subject:message-id;
 bh=q1pvDHup26t2gWq6fHUSx5KhOyJaw4CQELJ2qKSf88g=;
 b=+d5clqSgm87rC1q9Ol08GoDm3+lw2SvRxI9fXdTjZLhpFf6cW2vjFrUdJO1WfZNI5XmE+g+Y/
 MM6fJ1mG6qvBV6X7Na2+2Ueg2+YOlKAL0bUl9n0YQWIk4i4HvpKoSGY
X-Developer-Key: i=dirkchen@amd.com; a=ed25519;
 pk=NBIyLsVg/YYtGLruq9XLdLWx2PP/1MH4jDDQ1V+7wes=
X-Endpoint-Received: by B4 Relay for dirkchen@amd.com/20260202 with
 auth_id=622
X-Original-From: Dirk Chen <dirkchen@amd.com>
Reply-To: dirkchen@amd.com

From: Dirk Chen <dirkchen@amd.com>

The Anacapa board features Atmel 24C2048 EEPROMs on i2c0 and i2c1, which
are used to store retimer configurations. Add the corresponding device
tree nodes to support these components.

Signed-off-by: Dirk Chen <dirkchen@amd.com>
---
Changes in v2:
- Improved commit description to clarify that the change reflects
  actual hardware as requested by the reviewer.
- Removed mentions of other platforms to avoid confusion.
- Link to v1: https://lore.kernel.org/r/20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..b8d248d99d7c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -328,6 +328,12 @@ i2c0mux0ch3: i2c@3 {
 			#size-cells = <0>;
 		};
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
 };
 
 // R Bridge Board
@@ -362,6 +368,12 @@ i2c1mux0ch3: i2c@3 {
 			#size-cells = <0>;
 		};
 	};
+
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
 };
 
 // MB - E1.S

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c

Best regards,
-- 
Dirk Chen <dirkchen@amd.com>



