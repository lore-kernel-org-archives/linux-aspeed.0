Return-Path: <linux-aspeed+bounces-3929-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B472AEA71B7
	for <linux-aspeed@archiver.kernel.org>; Mon, 20 Apr 2026 02:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzVVl1RnKz2yL8;
	Mon, 20 Apr 2026 12:56:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776408114;
	cv=none; b=LuxHxR3S3MkUA5cVOxHT+YyTrGwGX0/XBtFNEiHamcSfew+I7texQaWaiP4tN5cDJkg21JwZZwFNzVkeZaiFIjMn0fcUtSnd1SAQJmA1we4KXMHHVqQ9g5Jq4qUlxn7Z6IVEM/vggAWbSHcNDynFgqt4otyxlSnDDrAk18ep1972M2mShI4vt/xMoYzCd+k1Kb9JsefTg4kmx0obBFTUgywvuU94ogQtAr1Z/Ff8obMrLsdUOa076MhfhTdASL7YX/EDFViwCl6CPYfHE8YQ5hJU8gDkgYpjWXiEDAFbR/lTP1tDcrNNiZyxPEcNke7pEgbA5sGUF0Jll20ut4Gglg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776408114; c=relaxed/relaxed;
	bh=j2zHQiwS+fAyZ8BA4NB+rKHXCimGldG+ejgu1ghuEGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cpXfHXMZEAI1WT9GrvQPh7uYYtU6R/jO10SxfnlnFzvj0AYCh6DsuHLZPMqG+bI5UYMOxxSNWBQLBWTYoLeJ3EaSMs/KP6rjy7rBuaYDJsNmOtrAKbwyc3cBOLwgFktcjKBDEpYq+wCC1aAwUDtsTnxLjRxHzYq5ZxwSydRJZjuxTmTXaAHgpGtzyxy5gCczJ4XDuXq6/4V+xrt7UitTj/N2Zor61+PJaVdjvJnKi1BFisWErvvUeNc6H3Wgo+VDUDslVKJcaK2ZLCTv/Kzd0tsYSPicw9tRLs+L3ieqbXR3BRXdmj+Bm/PRzRjgaTZTT5dJcCe1wlbYVyFkKRbshA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBGoPoO/; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+rex.fu.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NBGoPoO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+rex.fu.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxlfT5Sc6z2xNT
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Apr 2026 16:41:53 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CC4116012A;
	Fri, 17 Apr 2026 06:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74632C19425;
	Fri, 17 Apr 2026 06:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776408110;
	bh=5ILW9ovCD9rkcdvfce9O9NVrQf0affa8qsElbU+IUSU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=NBGoPoO/ysm/6kB1rqLeSuI0cda6XCijr57MuJr48/DLaikWp+TxXklLuhWiur8aa
	 ZW4UxAwNr07BWcxpa3h8hYtNuVx+znRS+lHzb031Jrv8UJ/X47I54EUj1J20R16pz4
	 7155x4O7LNQ/Zb78Nv89nGwmyjtvP1+oedUrIDKzT4QEAs23zsZO5LbeiiJgvp+rdX
	 OebX2KXEs182I3WZ3hCOaYbYb846LkCdyMVaIor7Cod1iUgWbBwZNP8F8y5gNuQa/Q
	 MXM7JO4hm8ZnoxoW6TFxhv3dAHDx1gkv2PG6/kn1Xk1DVe3inXml88N9/7uAcx29RH
	 yn8kZSaE5C7LQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D51F8E49D;
	Fri, 17 Apr 2026 06:41:50 +0000 (UTC)
From: Rex Fu via B4 Relay <devnull+Rex.Fu.amd.com@kernel.org>
Date: Fri, 17 Apr 2026 14:41:49 +0800
Subject: [PATCH] ARM: dts: aspeed: anacapa: add interrupt properties for
 PDB PCA9555
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
Message-Id: <20260417-anacapa-pca9555-irq-v1-1-9a6d28b1b656@amd.com>
X-B4-Tracking: v=1; b=H4sIACzW4WkC/yXMQQ6CMBCF4auQWTvJFKhNvYpxMZRRx0WtLRISw
 t0puvyS9/4VimSVApdmhSyzFn3HCnNqIDw5PgR1rIaW2jP1xiFHDpwYU2BvrUXNH+zI09ibunE
 E9Zmy3HX5Va+3v8t3eEmYjhRs2w40R47BdwAAAA==
X-Change-ID: 20260417-anacapa-pca9555-irq-3090d4120270
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Rex Fu <Rex.Fu@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776408109; l=2007;
 i=Rex.Fu@amd.com; s=20260417; h=from:subject:message-id;
 bh=o8qWPDdSQIz2wmiJKXl6X/Ju2Iig3de8Ah1xPVk1Lb4=;
 b=9MQxnVgP2xpf8cl0ReSJT9bCAGSgrGLhuJrX1lJDGwcxn2Z0N5+8gjRkpTj50taQzIWiLxU4L
 Rb3uKLvuM8zCiSq+XVL/I8mP31UxsiKnatCzhTZShNcZeUVeGzJucDu
X-Developer-Key: i=Rex.Fu@amd.com; a=ed25519;
 pk=26ECoh24fxrbXDKgA4hCmgg0xjQ+IxU97kXb46ovwgc=
X-Endpoint-Received: by B4 Relay for Rex.Fu@amd.com/20260417 with
 auth_id=738
X-Original-From: Rex Fu <Rex.Fu@amd.com>
Reply-To: Rex.Fu@amd.com

From: Rex Fu <Rex.Fu@amd.com>

Add interrupt-parent and interrupts properties to the PDB PCA9555
nodes in the anacapa DTS.

Signed-off-by: Rex Fu <Rex.Fu@amd.com>
---
Single DTS update for the PDB PCA9555 interrupt wiring on anacapa.
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 2cb7bd128d24..7319f2319bb7 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -481,6 +481,9 @@ gpio@22 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"RPDB_FAN_FULL_SPEED_R_N", "RPDB_I2C_TEMP75_U8_ALERT_R_N",
 					"RPDB_I2C_TMP432_U29_ALERT_R_N", "RPDB_GLOBAL_WP",
@@ -500,6 +503,9 @@ gpio@24 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
 					"RPDB_PWRGD_P50V_HSC4_SYS_R",
@@ -529,6 +535,9 @@ gpio@22 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"LPDB_FAN_FULL_SPEED_R_N","LPDB_I2C_TEMP75_U8_ALERT_R_N",
 					"LPDB_I2C_TMP432_U29_ALERT_R_N","LPDB_GLOBAL_WP",
@@ -546,6 +555,9 @@ gpio@24 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
 					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",

---
base-commit: 76b4ec8efdc3887cdbf730da2e55881fc1a18770
change-id: 20260417-anacapa-pca9555-irq-3090d4120270

Best regards,
--  
Rex Fu <Rex.Fu@amd.com>



