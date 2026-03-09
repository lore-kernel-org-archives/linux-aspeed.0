Return-Path: <linux-aspeed+bounces-3630-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC59FCA191
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Mar 2026 22:50:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVBzk48S8z3c9D;
	Tue, 10 Mar 2026 09:50:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773026984;
	cv=none; b=Ca8WDhR44cR0Zgbp/SH+FEbN/gwilYLQfUPU7WsXhniq8p9OfhCue4k2WSCEtpJO0wfmw/+06cZMAc7plsic37siZ53K0YSHeK8wWvrYAlRY1l3xD0zM+9mlhc2667+wyEdIn39Vw7y2zxwilFb3s3AgWd5mqtxJLh4jh5plobX7cC+F23YVVaqnztt8vq65cjixROSBPEmwuxemk+LWxkGOZ+SDElZJARVhomsUIdlWwy1ZRE2VvMVhRdQa8agrxdieRZHEgASCWV9Ks4F+ObuEK8lS3Q9PS96W/x43HeGoeW5irbW1C+iisdCF6saGGMujHQ35wQRfMphqlfRMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773026984; c=relaxed/relaxed;
	bh=vZXs/Amiz9wWEOx1f0xIKWGcAuGB/QH1ZLN8g6Wslk0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FLwaX4sdGPKF8y3romhLt0TJWJM38qpF3wIDJsSK80DKlWQjSmplfthv99Qp8uiiEC9afx04uUIp2sgggLlf1zVdIvQueXAk/ka8F5TuAAH3P4Z3Sq9rv6wNU700z0jm08TyRBfv5svAGMhR/zelobcmV4ltdK8djgAlCcAZAdd25kjYRejRLRv0BPnMyfvh/iVoRPgPWSZTpO7v3XmruDiDYxVvH4vT53KzG6a2FrPBEAS88GlSIzz908yphOG+92d2c7byhSr2kHVR0OdUdLIxJncsSwXBf06jRRZFrfH0/5orxdwVhribGoC7eDMJ1OLaf92uROWsH5Ep3cdPiA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dkfi2mk4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dkfi2mk4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=devnull+carl.lee.amd.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fTjDm002Gz2xdL
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Mar 2026 14:29:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 54DFF433DD;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A4CEC4CEF7;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773026982;
	bh=GaoP8wcFVTkbA0qAqdRsL25+1PTp6d7J/ewviONVA+o=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=dkfi2mk4t3JAolTuCkgrASkFRIEnwyTKbECop4UEOr2WwDuFqR5bZyD8xNfO8tZjT
	 Amhs1faU20RdXe3I6YSEyLysbbNCDlmoX1zZhgy2U3FvtVop73QEGXEhxAzpdXXIp/
	 gS635NNbqE8v58IoF6vXIiiK5PcBGKa5kp6Tjg+MBBQ6eY1ChzDc3BHZElGZPWQUOo
	 1Zu19V4fGO/ch/olguZ/5vTSDSj7L1Xp3JXAQsTuznFwae9ptoBaD+xkU9Ek0FuGFN
	 AT+F7JAnCW+OAx7iyOescsNFhuIUXFh8bXC5y1d3e39JAq2lKwzz2oXYbk/s/ABbto
	 Lr7xUiB9paYLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C3EA8525;
	Mon,  9 Mar 2026 03:29:42 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Subject: [PATCH 0/2] ARM: dts: aspeed: anacapa: add eeprom devices
Date: Mon, 09 Mar 2026 11:29:26 +0800
Message-Id: <20260309-arm-dts-aspeed-anacapa-add-eeprom-device-v1-0-45092310e0e6@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAJY+rmkC/x2NwQqDMBAFf0X23IWoKLS/Unp4Js82h8awKUUQ/
 71Lj8PAzCGNltnk1h1i/OaWt+LQXzqJL5QnNSdnGcIwhzFcFfbW9GmKVsmkKIioUKSkZLXNrWc
 iFT2wMMwYp0U8V41r3v+r++M8f8Xs9lx6AAAA
X-Change-ID: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 carl.lee@amd.com, peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773026981; l=628;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=GaoP8wcFVTkbA0qAqdRsL25+1PTp6d7J/ewviONVA+o=;
 b=kgrps2Go1O4NvQWUFzsxLNEgYXY5NUMhGVNxD99zrowxmzORxAcbs5rIdv1EZnF/n4UTaLfVN
 vEF+OVFHqZ9AJqv/iM04dPXj3sUtCJWN4uWI6C3XLSaA+E4Ohews4Aa
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com

Add eeprom device nodes used to store FRU data for the PRoT
module and NFC adapter board on Anacapa platform.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
Carl Lee (2):
      ARM: dts: aspeed: anacapa: Add eeprom device node for PRoT module
      ARM: dts: aspeed: anacapa: Add eeprom device node for NFC adaptor board

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260309-arm-dts-aspeed-anacapa-add-eeprom-device-a1aabe06a35b

Best regards,
-- 
Carl Lee <carl.lee@amd.com>



