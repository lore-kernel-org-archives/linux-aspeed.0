Return-Path: <linux-aspeed+bounces-3181-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0EBE668AF
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:55:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFX91Grtz2yFd;
	Sat, 20 Dec 2025 17:55:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766131870;
	cv=none; b=DF9P9GL64Kw5JKOuM36D7py8eZn7G5up4UgRiY6//wOPJVfwkYGzlVBUBhhZkNIDBd7GpFNv6cmVfaXFVAE1L/JW7ONY9A/xdfUqIdYxt1KUybJ20QaT2Xeio50p6Q1PO1Ormj1lIb+6IwoOOF49CXehl9T7BsxdTFvGZl6KCXHTyhtehvQdP/6/l5cp+xYYAuMKNKTYCzpdHqKb3ZbV8NuhypA1g2kq+PGUfW+2SMzFWaP7cB2SxH2ovaItkJm0lLGgxqhAOFEpjfzmFTnIf0c61mfU8NSPdb4mhbXXqv9xXQaKUREXcoFkpKBqfIVP9xUebm1kNN898gHgQ+M0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766131870; c=relaxed/relaxed;
	bh=oieK3l8IF6JRtYEigMvXLtMbPyL5df1jv1S8R3nBwz0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVidqHiDZx5FgCgOhJXefNktCZmmIob/tZFZEM5B0RC5wq/wZwNhNVY1L99258t6bcsHiykcVaYDnqiJ93R9moRBdaLgws9YUu5kZ+To5MXb7E7DB9AbttHte1sc7K+zB4u7bfAhc5XiIgCDLKZZ5ncVZw+8ffGRc5E3fvDZMtr7IpFwPGCDvdk5/JK6nhhme6RjiuFfiXQ/+5JCsu4h8ZNEJDI/pnmSrs5PUfv2ZesqD3KWz6OqMYlJZUTEu01mUSfU/dM7ycMGIrPteM+k6dPM9U0Wcl/K3OrMNkuIaAJxCXmdUHjnZsW1G651I5JFlebDFQVVedUBEU9HZvLtHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bGqc06UI; dkim-atps=neutral; spf=pass (client-ip=209.85.210.174; helo=mail-pf1-f174.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bGqc06UI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.174; helo=mail-pf1-f174.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXgGJ2Vtsz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 19:11:04 +1100 (AEDT)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7ba55660769so1288260b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766131802; x=1766736602; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oieK3l8IF6JRtYEigMvXLtMbPyL5df1jv1S8R3nBwz0=;
        b=bGqc06UIwTgs3qoC/utYYgI0pQOyqeiH5kFEoO29t9CXATIIbdo088mDwsH0vQUlW/
         DYRXZJStmMufz5Tm6jlVeHo8XzeNSn/NDcC9XvfhWV2lQHJxPGAXwayg/iv9V0m35UaA
         2JG1ZaY8JD3W2bshKGGpy6Me+LMyRlmveedBax0ndsLktK/YgeS55QrE/m9qpyECfnlo
         UJApPIv3gBFhjJ/d/ddROiD0HaXN9wCq3p6Ir04Q4EsfrVcLrYR1PW97YUy2nB58I8n3
         5cjUYHox8SisGRqRJDakPtLMUomG4P69qswdR0JPlSDP8P75DCyeYE8ZPDBshD3I5KeX
         BmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131802; x=1766736602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oieK3l8IF6JRtYEigMvXLtMbPyL5df1jv1S8R3nBwz0=;
        b=bHy/ybjtWgxxpHf+nm2JWcTneSflWDsmXGo4KGR+FAhJmnYAdHiwQ5MlZoQ3mAMQA3
         yNZW9kP6fGQuFR0q+Ex0L7aQy4jKWVDVHetA8ZAFn9sfaZU0ZHfzckr0uqwCJ+KYNvjY
         Pm58qgV9mYguxlluuORKZMD8z8S8KVcMNhmhNvPEq4pKhdsXoLzJ4kirjeFz/aiPbq0J
         YUZPGSEqrzDZOLSQLlgjD0/VQyEvt4BZvRSxHukgf6KhMwaNSdwaJ5yEQRZ4SUt1sUn2
         9MkHx9kw+omUuLTJRb0NUB9RKq2gcZofLAg/Br1XUPGVzWCrC6bOF+38HARgh94Ya8Ku
         fNmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt6095f+cQouWwZ99SNcZiFjINGSfSVUAXMzB5qSIxeNHgPXede+TgHl5IBS3u6oUCLUDB+BI/6eqLlNI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxeItUJHUZclXiG9SFZhUkzHtlZM+nHjny+AvC6V4SsMRBsk2Ab
	3wXBRrlP5vlvOWei/ovT0a87xAskV9QDJy3nF11f3szAhCuDIP3cFE+5
X-Gm-Gg: AY/fxX7dHDJX5IBf2BtiUNgOcNr4spN76tXpOUExsgTX6mYS1JJGQHOa0cyKzWJ+sE2
	W4Ed86Qwc9iiRmKPOTxkhyOcAVzMjLv0VeQtWMMDYmpBYPskKTKNubC243gr7FYuhf/Za05GaZv
	fa4ccyJVR/zcW3vbFT3f9eIrjA3hQROEYD1CzrQWqH7dEmftbCEPvjEXw+DT3AvOO2JNNPGT3MP
	XVz0vS2aoCdcjsfjWxF89GgPLYlQV32TXM5IRX22ILcl1kGlKa+C3FZnlc3QbddBXUeZ7ggyJTy
	z05QqW8VKOVXRf1Xx05ISTD/EmN6f2PRzAL6ZN/UnD8R4z1bg0g4TDryrcYiLIz4Eo0wbBMii6g
	4hlmi6iCLkVsSbbS7ZObYSJZpfHPPrkoxPkux9OaDm7BrOmfV4dUFZM82U0JnozUCEv+6ebLfFJ
	fm0m6bb8GHvYtEt2Byj9vSvS319j96v2ACp4SxFOkapSHkSnudX0IFf2mLP0/6/PlWsINq7xfT8
	Y0FvM2yNNTDXxDE4EZvp5CMlCq2gzqWV75OlChtXEXfH5MLiG9k017InDcTFH8VLxYwWxovrvQ5
	EPeMhS/yXOY=
X-Google-Smtp-Source: AGHT+IH6O9k87iUuZRQCfjVUNtyzbvFvDBUF0hfyDpwm5q4iSnF7KU2QOGhjZzrGAX94hmXJlBmPPQ==
X-Received: by 2002:a05:6a00:a882:b0:7f7:26fe:c92f with SMTP id d2e1a72fcca58-7ff64cd5fcbmr2018064b3a.29.1766131802504;
        Fri, 19 Dec 2025 00:10:02 -0800 (PST)
Received: from 2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net (2001-b400-e3ff-afb4-41b8-b31c-89b3-0a14.emome-ip6.hinet.net. [2001:b400:e3ff:afb4:41b8:b31c:89b3:a14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b423d86sm1597274b3a.26.2025.12.19.00.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 00:10:02 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 19 Dec 2025 16:09:54 +0800
Subject: [PATCH v3 1/5] ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12
 bus speed to 400 kHz
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
Message-Id: <20251219-yv5_revise_dts-v3-1-ca1d5a382013@gmail.com>
References: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
In-Reply-To: <20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766131796; l=1020;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=hdlRtRi9TLU18op7sSDjRmIwRirYAAfHoP1MDNioDPo=;
 b=iAJWJED/ZWZRo52wpqJhzFlhUoPTycBrTupcQzGdg/tHGBb9ORmlnq+1D0gO/nkszCJikiMuv
 +qDp18nvbegAk/VpV07EyHZlegt87Eor/yxHAO066vJpbUXe7X48Vam
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Configure i2c4 and i2c12 to operate at 400 kHz instead of 100 kHz.
This update aligns the bus settings with the hardware capabilities
and improves MCTP communication performance.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 2486981f3d6bd36f3fe780b21e834b85242f8aa9..7991e9360847532cff9aad4ad4ed57d4c30668a0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -231,6 +231,7 @@ sbtsi@4c {
 &i2c4 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {
@@ -782,6 +783,7 @@ adc@4b {
 &i2c12 {
 	multi-master;
 	mctp-controller;
+	clock-frequency = <400000>;
 	status = "okay";
 
 	mctp@10 {

-- 
2.52.0


