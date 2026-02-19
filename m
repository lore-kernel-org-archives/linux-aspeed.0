Return-Path: <linux-aspeed+bounces-3526-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0373CC531E1
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Feb 2026 22:48:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fH7nl3H9rz2yrl;
	Fri, 20 Feb 2026 09:48:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771515908;
	cv=none; b=YpFUkePDgf8atbe+S6OtZkUdgNiQYgBA9dkSxqEbU2oDjM8MawFGw/ZR34MPp23dttcYoOWtieWHjgbowizdfweJYe4OpiBLEJUhLjN8K6hQcsBR93C9Uj31g0d7X65XYzWRMs0ksIUEsD6W1AGfx3yQnPEO+uan5jFeaP4IfLqcnNkneddXC7KlmwvCb5uq7jgKCLZTBf8zwbu0R/IvqoDROXb78vhEN4Ah/OccsknW4xiwdKklezsg90ToCdg6bO9X2m18QKPIE5MqcHrX+edB2QciJ0/24jzg7/t+lh7k8AFQQlqYrRF9rupnrXd9JWI48s0Ri+XxitR7KHONWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771515908; c=relaxed/relaxed;
	bh=eE8E+grBmi8D3c9kMH3BrseGSOYzb2/Hbi9Rf2w2QQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TCvd6cw3E+M/bHaiMvPHUSs1J/qqUOcRmnRLFK7Wblq8n/89lfcqxxMsOXYXf0eJKhYnMyIdEKkT2RS1arVY61b0VlDp14zGGHW/ZW8U0TQZOUukwGiTJypPl6MMyzVOFLiXP9zvqF3ZBSn2JPpL2iC4cH2ZWqQqIx+wQKHdYW0csH4ePhrHyZB/YRsVuG4GswXa0LJYR/c454CGTpXM/hOHMJv+NwoWx7A9p4XlCAtnQALThBaMAVij3iSab3lLsePZI7PA0auuyz3JxJenikNPN73iysAXmv+8T0G9jv+nSrEBGdx9x4f2fuNtk1N1+oUHlCSKwqacp2OKDGLY7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cXebsbrT; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cXebsbrT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=devnull+dirkchen.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGyPb1tFPz2xlj
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Feb 2026 02:45:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D3A760054;
	Thu, 19 Feb 2026 15:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF78CC4CEF7;
	Thu, 19 Feb 2026 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771515903;
	bh=MEZIWk5e9iRnjMniEvcze5MIU7mUhoymJgLFKvBIwxQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cXebsbrTQgF5mniykYiyeGQVEbO8JzzkkCbu1/vbhC8UUO29DXHEehHJiNU/ZbJbn
	 s84RQKoi34A/mhaxJADHAKA3tX3mZEOQxg27ZLkhazft25zKZyGWTPBPZ+18+4bQFr
	 nLDnA4BS79JeAc3s2ziLgUZ6KXZoqdYWhk/nsL4LiVyyCzXq7/Fv6P6w0j20po/S9A
	 A1+9yNB9zn0DxysDgEZFfSioJ11IQ4Vh7uLgRSLleilxlqFs0xA7HmIUePzDkjdaeH
	 0RNxZyNnCuKNDHWw9rmxlpNj658vpdlqfNvgIbR6OOnmzzbxU/SRGQ35pqDWcoKF4y
	 tSKnk2BjIeO1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBFBE9A03B;
	Thu, 19 Feb 2026 15:45:03 +0000 (UTC)
From: Dirk Chen via B4 Relay <devnull+dirkchen.amd.com@kernel.org>
Date: Thu, 19 Feb 2026 23:44:47 +0800
Subject: [PATCH v3] ARM: dts: aspeed: anacapa: Add retimer EEPROMs
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
Message-Id: <20260219-b4-anacapa-dts-fix-v3-1-4f70fd2d1070@amd.com>
X-B4-Tracking: v=1; b=H4sIAO4vl2kC/33NOQ7CMBAF0KtEU2NkOyZbxT0QxXgjLrLIjixQl
 LszSQMFohnpf+m/WSG5GFyCrlghuhxSmEYK5akA0+P4cCxYyiC5rDgdphXDEQ3OyOySmA9PJnn
 tvWux1NwADefoqD7Q251yH9IyxdfxI4u9/ctlwQSZVmkuhGou6oqDPZtpgB3L8htofwKSAO+Uq
 rDmZaP9B9i27Q2awI6R8wAAAA==
X-Change-ID: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Dirk Chen <dirkchen@amd.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771515902; l=1779;
 i=dirkchen@amd.com; s=20260202; h=from:subject:message-id;
 bh=e6uon8fDwRBTubN8ywUAkYjtYXx6mIWRj19Qi3Y6T6g=;
 b=yPhRCyA6wRLeJlcr0K5q0+OqpgObOJe/AzDQSJiYDKvOW5cRhT9MUc8VQfNRlWLPZMUt0q/EO
 hdK+ttB1juxBEjXrPe59DC/BQLuAYSuWc+elt78/2d3j+BRmO5H9K/+
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
Changes in v3:
- Reorder I2C device nodes by ascending address (place eeprom@50
  before i2c-mux@70)
- Link to v2: https://lore.kernel.org/r/20260209-b4-anacapa-dts-fix-v2-1-fe446a7038bf@amd.com

Changes in v2:
- Improved commit description to clarify that the change reflects
  actual hardware as requested by the reviewer.
- Removed mentions of other platforms to avoid confusion.
- Link to v1: https://lore.kernel.org/r/20260202-b4-anacapa-dts-fix-v1-1-20d4b0114854@amd.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 221af858cb6b..1502773d9c30 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -300,6 +300,12 @@ &gpio1 {
 &i2c0 {
 	status = "okay";
 
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
 	i2c-mux@70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;
@@ -334,6 +340,12 @@ i2c0mux0ch3: i2c@3 {
 &i2c1 {
 	status = "okay";
 
+	eeprom@50 {
+		compatible = "atmel,24c2048";
+		reg = <0x50>;
+		pagesize = <128>;
+	};
+
 	i2c-mux@70 {
 		compatible = "nxp,pca9546";
 		reg = <0x70>;

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260202-b4-anacapa-dts-fix-207ffe9a3b0c

Best regards,
-- 
Dirk Chen <dirkchen@amd.com>



