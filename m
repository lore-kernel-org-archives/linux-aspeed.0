Return-Path: <linux-aspeed+bounces-4126-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03431CD5BB8
	for <linux-aspeed@archiver.kernel.org>; Sat, 23 May 2026 02:30:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMmN74p4Nz2xtC;
	Sat, 23 May 2026 12:30:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779503447;
	cv=none; b=j129dLQhhPbSVXDNnnhItwWJUgrFkK26LBfX857R3xKM2PwdXBlo8fBWgEjb80f/g9NqGRCWF/JyktKa3AVN9LYB9OMP41GOdcJ0qJF5uuuQmf8qewS/N3KtSgxgEdXe54in40Ccn/rCHIhT1+Xke4iapInXOl1G6zFwQyTeXlR7QHf0Bb1A369/ND1ki3DDjC1G2U5IAngQnzt/TNujeJtn0E8GjWp5/yBZnv7CwveD4NfpvIMK9MDwLzAZlxbUuxOohJWdrUeKYguikKVP3iMX4zIxWwrc7UarsesyIYQSg3e0PdbSvnsjqyKhLTfKPXyJjEvCr5FkcA6kyW2TtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779503447; c=relaxed/relaxed;
	bh=sHPUJ3czC5a2AiOeeio5W0mr8v8tHvSIXMOz+fsp+lA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TaoqxhEeZNHl0l3mgzDv5OvpQkk9XKU/dZQALJRKDe0g8pM0QI+M2umuZGKkQUzRzHxD7syXBXurw0TXKeiFHS6kOj1eXWGgDyI0+5q/j/1BM2tuUcv1W9YfTou0Xk1DWa7gJXuh6lORF+Cc/BOAZIlEMQu/xhEW+hM7q4K1J/6jQmgIXTgJZrcx9WtiCMtOyzY3FuCvc7pIkO/OAYrQhcGcOgKOlc9/NFKeZvEDKoLUVgZxlMEQ4ExcH+6Es2zBhA6OohP9uYNPx68Qw5z/KoHSCgjAmGkcP7m2uPkCiCZ1DQfJHPbYA20Q3ZuXpld6vC5saeUxgkf5EqVVMK8dCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aGgSTsJW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aGgSTsJW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMmN66wNvz2xfR
	for <linux-aspeed@lists.ozlabs.org>; Sat, 23 May 2026 12:30:46 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-36974217d4eso5118332a91.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 22 May 2026 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779503445; x=1780108245; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHPUJ3czC5a2AiOeeio5W0mr8v8tHvSIXMOz+fsp+lA=;
        b=aGgSTsJWPH/fuhS9EQGCXJ4TYtkQ13utHsOmmwhq1o/qfYiarb0dorCjjZh5+4l7pb
         37Yt2+GvrqkZhbQ1uGpnqKUl/ySNA+HVLkHrcaV845+KyKo/fzYus01y+SDOwcMewnj1
         nbJzJikXPfFPPcd8WgR0mgwrjQ0BHhXtIU27PxwqiFqnJd8B137Ay/nDOcbCq5bS04sb
         hUrgZEcIGqGIzQ961qGxhbJjKfRVKlVPwky0PpUh2Vl+m4VMvEGROsAO5ZCL7azMM6ot
         29E2QUjei5mB6ResQvqzTryANIrGczfrfCKLYQH+JVItVqspPrf1cpdgJfUfpwgzKsaR
         8AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779503445; x=1780108245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sHPUJ3czC5a2AiOeeio5W0mr8v8tHvSIXMOz+fsp+lA=;
        b=ZddjO/6XhxqFk92CwZY0Le1YdPbYjHVyKJNlwgiVUQ6aX35rz0Dy+dKebzoIMBZEhS
         4tQOlsTFLR1f1Dhg/d6uNdq3bpTLKPaNoIoZY1Pi0CC71diDenGakXFWjk6+jaHKNlUo
         WF+jSB9SgnJFU29CBnOWrQgA9AuNDFQcnDqxDebVEXzFOqesbhsiKodfhOe0jxpTr7jT
         OQF21l/F5HyC7V8RjQfK5qDnOUfML8zAKdW8jX75H00FsCl72PzAdLLSKyu/9Y1Uhk7V
         O7wFVEaPELE/EGho2UAODC4fSXIQdRM2hJaVKoseQLUa0C7UrpyBmKWjnsiGIBhJeXDF
         ZNsA==
X-Forwarded-Encrypted: i=1; AFNElJ/2i+qhlxUGKYiyjTUHz20c3UGJSTJCyiw9FQDtu0irKdo1l3KmmHo9+TKnA1CV8NvQmu9Wr4x/zSwPTQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyI1WEgGStivZ1wVa8x/DVLuJ6ZznUYxTLC4RyXwPKb5N/IAPm+
	6rYoEpeIHPBmrv8SGkLL5oAdF/VwohcpBqdx5FkTyl1vYNp75TmSPixT
X-Gm-Gg: Acq92OHtAWnjVpdtGLfvIlGrdvtWKWyShhVUkuFnbZXtnH+I+BMjIJa1NneBK5bNMdk
	KSu0ujY4l76qQRIL9g3e3yrfr9/W1LC3YXxYyHpOKZLvk5CYLGv8jGsjBnWMewPaU2Gkbzdw1GJ
	MYPN9iFvYzARuFlXG9GqkoOQdFs/OhNW2w6PMlKeM1vysF1iCOfK55LlZlX96P/zoJqQ6jkP23B
	jddUrRlat+QVbfr7EkI60vHTPeexlFKmAZZL15C0MSAkOMn4ECklF24PpnIGgvvakmNFT5QbLIg
	fd0nAgZ3Qu5zS9lk4HfAjzEvS9m11ijH9bzgUdtS69xvHMoa1LkLvX354rnaFJlqAjMHJ1FvPi7
	J3L7ahHkkn7rECpiJEybWkddqPa/e31G+F9Z0HeTooxDaKW9G9Vro1P0BiX4Uoh21F8WdAsVuKq
	YV4xxEYq+/+bZITVunyZFppaLTg7Rn372HftJZmw1r+5OLqPMl2C39ZAad31hw2E0PmQ==
X-Received: by 2002:a17:90b:2f83:b0:369:e4d4:7460 with SMTP id 98e67ed59e1d1-36a6784d120mr6270352a91.21.1779503444976;
        Fri, 22 May 2026 19:30:44 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a71d944c4sm3010287a91.1.2026.05.22.19.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 19:30:44 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
X-Google-Original-From: Potin Lai <potin.lai@quantatw.com>
Date: Sat, 23 May 2026 10:28:08 +0800
Subject: [PATCH 2/2] ARM: dts: aspeed: sanmiguel: Fix the CPU_CHIPTHROT
 linename
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
Message-Id: <20260523-potin-update-sanmiguel-dts-20260522-v1-2-169f5fceb5f9@quantatw.com>
References: <20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
In-Reply-To: <20260523-potin-update-sanmiguel-dts-20260522-v1-0-169f5fceb5f9@quantatw.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>, Potin Lai <potin.lai@quantatw.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779503436; l=1342;
 i=potin.lai@quantatw.com; s=20260522; h=from:subject:message-id;
 bh=Q4E3ZBST3Q3ly34aY2FsZlQq16jx0NpfboLmFcFmWh0=;
 b=Ruc+O4VL0C7Z8Ul8A7X6wFf74EjrJxDSMlytQIRn/OlyWuyYFoLNzwlw/mw93ArtJMjKo7bJ7
 HOfUx0FVyttDLIBwrTXOHZ490kWWtc7AqhVgNJDr5A4ZiBF7wLIJ0VE
X-Developer-Key: i=potin.lai@quantatw.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

Fix the GPIO linenames for CPU_CHIPTHROT signals.

The signals were incorrectly marked as output ("-O") while they are
actually input signals ("-I").

- B0_M0_CPU_CHIPTHROT_L-O -> B0_M0_CPU_CHIPTHROT_L-I
- B1_M0_CPU_CHIPTHROT_L-O -> B1_M0_CPU_CHIPTHROT_L-I

Signed-off-by: Potin Lai <potin.lai@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 61dbef45f8b0..d7ed497d7227 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -224,7 +224,7 @@ hpm0_ioexp_20: gpio@20 {
 			"B0_M0_LEAK_DETECT_ALERT_L-I",
 			"B0_M0_RUN_POWER_EN-O",
 			"B0_M0_RUN_POWER_PG-I",
-			"B0_M0_CPU_CHIPTHROT_L-O",
+			"B0_M0_CPU_CHIPTHROT_L-I",
 			"B0_M0_SHDN_REQ_L-O",
 			"B0_M0_CPU_SHDN_OK_L-I",
 			"B0_M0_CPLD_READY-I",
@@ -398,7 +398,7 @@ hpm1_ioexp_20: gpio@20 {
 			"B1_M0_LEAK_DETECT_ALERT_L-I",
 			"B1_M0_RUN_POWER_EN-O",
 			"B1_M0_RUN_POWER_PG-I",
-			"B1_M0_CPU_CHIPTHROT_L-O",
+			"B1_M0_CPU_CHIPTHROT_L-I",
 			"B1_M0_SHDN_REQ_L-O",
 			"B1_M0_CPU_SHDN_OK_L-I",
 			"B1_M0_CPLD_READY-I",

-- 
2.52.0


