Return-Path: <linux-aspeed+bounces-3221-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942DFE9271B
	for <linux-aspeed@archiver.kernel.org>; Mon, 29 Dec 2025 01:46:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dffFY5l6Vz2yFs;
	Mon, 29 Dec 2025 12:46:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=49.212.207.181 arc.chain=redadmin.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766572990;
	cv=pass; b=NVOYgQ4ZHraKbPdXngcNw+1Ip3jtfmvX5szBNhMVLTIsKAc5rzFec3sa/a8MPd+wgL+spgWG62FPlJwLnO0G1IxHequKypNt2LDesSVjHdaKS0GLv9Y2lr/VqqO1+hiagfdmzabkwR74x2C8S1APi+E2lQX/5f1nKFlpYXReLJrvSpxq8sYwoMh48MEbybVT9mnO8/uZI7hkru/LDkJmtg6MkELbnxHfLY+pKPqD/aPA7b84svHEv8aKd57Tro8kD9LhdDg7YWkPLDJsZnLzcK+SjfahWO6AwneZO7EbabOJvW+Z2MZQFhbgeAPw9z5qDk+JX2XsbC84jiv6MRMijw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766572990; c=relaxed/relaxed;
	bh=55Wdlxhr6LRYHaQsgdonHzFOxbh0VPJ42HcRCsxXoWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXJGzhX5/parVEzl2uNNe8JMuxBXRimTJ7PLxG3YZiEWa8GCfrdPlNlLngFvxz6IHEtVyZJofet34mN78ejVsYLPCU20p9p8xxSN5w6YUVww4UpbwQAPHODL8123k0iGYZpqst01u1uwNKp6loKOcF2NICb/Qeh5307pJQ9onxjqbGZOEEE/GQe+sVQILRI3B1cbGJp5KrgwyUVbIQ04ni6YoM6C6Bi3XKmH98qn5tObYsKa9fbKGHU0l15Mr9vdvyT5m6puVnZJ2TVZjTSgSYmyYVXjMcBf9UflaLBGq8xxQxkXftCghHxFaTda5CWsxHERsUMbHgmaZWFnQTs+wA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; dkim=pass (1024-bit key; unprotected) header.d=redadmin.org header.i=@redadmin.org header.a=rsa-sha256 header.s=20231208space header.b=dildJhKG; dkim-atps=neutral; spf=pass (client-ip=49.212.207.181; helo=www3141.sakura.ne.jp; envelope-from=weibu@redadmin.org; receiver=lists.ozlabs.org) smtp.mailfrom=redadmin.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redadmin.org header.i=@redadmin.org header.a=rsa-sha256 header.s=20231208space header.b=dildJhKG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redadmin.org (client-ip=49.212.207.181; helo=www3141.sakura.ne.jp; envelope-from=weibu@redadmin.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 7281 seconds by postgrey-1.37 at boromir; Wed, 24 Dec 2025 21:43:08 AEDT
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbpPS5gN7z2xqf
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 21:43:08 +1100 (AEDT)
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BO8cq3U007035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Dec 2025 17:38:52 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id C4441109D5746;
	Wed, 24 Dec 2025 17:38:51 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pOYzVlgpNVHq; Wed, 24 Dec 2025 17:38:47 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 8874910A0ECCF; Wed, 24 Dec 2025 17:38:47 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1766565527;
	cv=none; b=gzgMwxS0W8KiSRcwpjGyWYl9uHWSmex6mi7qhb/VcYSN42rLkbn/KW+1zx1FBUlPGm18FXA4GQPrFMQG0HOs0492neUW6GPQ63cIn+sA5WwES3unYsmPtOoxpp322GGw/xSB9AzVcsYqY5sSnSxJm85ylou6ORQx4DgPIkgVAXI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1766565527; c=relaxed/relaxed;
	bh=55Wdlxhr6LRYHaQsgdonHzFOxbh0VPJ42HcRCsxXoWA=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=BCPNHvQwYypZlGR9D9qFIdmE2/FwFiEYOipg55d/jvQL7RBN7kVwfzL3kfcQQCi7YgJIR2F45lFilGgNsh6czrydO3wTLqNOToA0SB4Qs2CzmD5lKXErHWEKVZPsb/qfqz2HfyKdO9070RGFwh4pFzLLToHS5njdaMqyVot5Q+U=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 8874910A0ECCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1766565527;
	bh=55Wdlxhr6LRYHaQsgdonHzFOxbh0VPJ42HcRCsxXoWA=;
	h=From:To:Cc:Subject:Date:From;
	b=dildJhKGDsFhkveq50tYibePfrP+nFZutqRS2kMXGNw6oO3sqREtQiZYTxDUxWqQZ
	 +RTPh3MrGJiG/cKuKIH6hr8e8xUjYljCw6mqcijSimqa7G0bwdSAC2Xz57S1A4+fZv
	 sDt/UWSBzUswPLoKJqdBWCB5hVmqQm+yuhonR8Dk=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: Rob Herring <robh@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: dt-bindings: hwmon: aspeed-pwm-tacho: fix typos
Date: Wed, 24 Dec 2025 17:38:45 +0900
Message-ID: <20251224083845.2727976-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: quoted-printable

Fix "upto" -> "up to" occurrences and add missing "be" in one sentence.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 .../devicetree/bindings/hwmon/aspeed-pwm-tacho.txt        | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt b=
/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
index 8645cd3b867a..d1db4adb2df7 100644
--- a/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
+++ b/Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
@@ -1,9 +1,9 @@
 ASPEED AST2400/AST2500 PWM and Fan Tacho controller device driver
=20
-The ASPEED PWM controller can support upto 8 PWM outputs. The ASPEED Fan T=
acho
-controller can support upto 16 Fan tachometer inputs.
+The ASPEED PWM controller can support up to 8 PWM outputs. The ASPEED Fan =
Tacho
+controller can support up to 16 Fan tachometer inputs.
=20
-There can be upto 8 fans supported. Each fan can have one PWM output and
+There can be up to 8 fans supported. Each fan can have one PWM output and
 one/two Fan tach inputs.
=20
 Required properties for pwm-tacho node:
@@ -28,7 +28,7 @@ Required properties for pwm-tacho node:
=20
 fan subnode format:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-Under fan subnode there can upto 8 child nodes, with each child node
+Under fan subnode there can be up to 8 child nodes, with each child node
 representing a fan. If there are 8 fans each fan can have one PWM port and
 one/two Fan tach inputs.
 For PWM port can be configured cooling-levels to create cooling device.
--=20
2.47.3


