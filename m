Return-Path: <linux-aspeed+bounces-1112-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E581FC36000
	for <linux-aspeed@archiver.kernel.org>; Fri, 21 Mar 2025 07:28:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZJvFf4f4Bz30MY;
	Fri, 21 Mar 2025 18:28:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742542134;
	cv=none; b=lCJFFaylKMkWHVrFNoWP/gGPT0Klb4zzvJ3Ce0PdueXPIiGrgzniON1P45h6Q9DWJL12RBlACAceHfDHbPuyQGHJXuj0/rZNn3pfwF91T6NGsE2b1/uFCLaydBJyMH1a/3kMXPdxqvxBApuZRfn6DbwC7x2L62hFbQOf2RjCFfz9q8gN0Fj2dXGDUfFNfHNb51PnjxG2TCtqJlXe5yIJeB0ey7fiCdNozDWPRRjOkLyZQ5fdzQiNpT0WNmtzYodEqlx/YQfNAxnjE96V9FqpjUlhHzo5J20/jEfepXtOWzyIfO1hQ3TlK2A1pABfeuZ4jTpnO2DxWfYCtRAwknQgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742542134; c=relaxed/relaxed;
	bh=BbhBstTf/rpGE79fQcNaD6V+9Y2DvcY3tvSTTq6IewU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L6cDkSNFzjsOfJ04d1SZEeK8kbYScIBareC1RZVcxDn0IymSg8iuQJmneHz/3eqlcWWf6frFwS+tOfJLZ3HKcZCQmiVXpvacD1KGXHK191mic2YE8D+l81WX5fBcnlW1jEvQV47aegJi9iN7CnJPR+2oiRBq4f0g93VUTCtZC3HL4RlGGDVp/1CgCnDsYR0sVoEiGiIvRP5rcZ4nP01EH/qCHBRfOCDTToOF3OJ2s2yqX5F/kV4fVZWw2YOH2a+JlU97xf3c4Vzk1zY8k6X26O0LgOHI7wrGo9eU9EqQFa3wXQeskaCHgCddtEypUj1pmvzOxIby3RRLqHsfAqoBrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ic0HB6CS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ic0HB6CS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZJvFd6fKWz2yrS
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 18:28:53 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-22409077c06so4484845ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 00:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542132; x=1743146932; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BbhBstTf/rpGE79fQcNaD6V+9Y2DvcY3tvSTTq6IewU=;
        b=ic0HB6CSak3q0FABKSje6Q84hMP1eAWAge8bYjXjVjVL+e9fDFWP22FIQjcMBF+2wi
         9v/xLNFax95n6zGEYp8lg0tWkxIKJOCHhQ+kwon+JOaRe+joD/Wn/hpBQPGrj2fXJZLL
         +iogcxgjJdNEVOD/oh5dYk7+exJndxMO4rWw83+q5NfxZexKqDbJNh2m4WhIBNDZdN4H
         bADY0K2dIA0i9r2QSKS+cvchZeESCuCSUp87kGC3+joWyhLXLRUoP3iVw7SntQzJH6c+
         47UYjbH32Bn0ZpdvKbQWoVUF5jkWV58Ry7JHn+FzNapSNs8sjHGArIOiy4kdVjyeGJIp
         HOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542132; x=1743146932;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbhBstTf/rpGE79fQcNaD6V+9Y2DvcY3tvSTTq6IewU=;
        b=QEUFU4jVTppH1Y77/+gOjgKnVL1y2ku20zyCm3O1C3rcJg12ec4yE000nX4j6wMwry
         1amZG+eEZ5FfN06L5Txsr5dHiZoqWBV+ugIkPj+0YPU7Gm/T7sXGxpa6sVlaJEjxoxk8
         EAVygEpEgn/p4PQoeuFfp+ZqvGr3ki4xl5w6Pl3D2pNpoExkkGYrtJ0oqOqzEBu3QwpX
         1XCLcg6QW9aJZLND1FEwmq9W7ilhfV9gdtChbrEdbwvBdrIfiY/SDmRnn4a46E0g8OK7
         eX/3PEZWIohKV47YlacI04tezYV6LaaugSK2ozLUAusm7Ec9YKbRXClyspBQrt8tnBES
         ReMg==
X-Forwarded-Encrypted: i=1; AJvYcCX5AsGELBnrci5Ouxo0AvPN155n1xqP3kQ85IUDIqbf/ohv69gsMkDA0zYKsfAHyIWBWVAVKHK/KTZE5u0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/T9hEWErO1Y+/vT9YFVkWFx0ZQrRVjpH0G2v0T70A3/Y2oraX
	ndGq+C+A9Uh/nnI5OzvQwpT/uhM7EADORo9GbZh/YHOvzrdZ5B/h
X-Gm-Gg: ASbGncvw+K5Kt38Aogowdh6GCn7ZenI/glpmR7lbGGfxgVwad+na13pgKsSAzzbmhdD
	Inh88WpVP/XBGti1tGzzI8h+XOPhnthCKmgOzdg2KnBrPnuQ9pKKDjS3wpyo3EvF4kfip4J1gyP
	tNa7Z/Iw69xl3nB26F8hKUihSYk8Xe7hwH/mkUkwcfCwtRvnfOi62Aiqe0RQNQ/JDzM2kWOl2LU
	GwEZSO2jvGySImUrba9Jwk6/TCboL6r+0QUOaQSXtzRA2rVlNiCFvQ4oXmxMpp+y79BU1EN0iZz
	Q5AeLG9w2Je0jZed0Nvjzj1Ddc5U5E8uzvTz9fhek6KKwoA93l9t5IDULFJUK3j6bvcBau8r3Y/
	AdPNHDSJyYY1EPjL1mFrecA==
X-Google-Smtp-Source: AGHT+IEfn10cVp0MmL9KAA7HT1bbZ8SZCvI7q9K72uD16FVBGG7ET0Q39wXEka05fFezPLWLFC4AYA==
X-Received: by 2002:a17:902:cec8:b0:223:668d:eba9 with SMTP id d9443c01a7336-22780c5587bmr48813795ad.10.1742542132085;
        Fri, 21 Mar 2025 00:28:52 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:51 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:11 +0800
Subject: [PATCH v6 10/10] ARM: dts: aspeed: catalina: Enable MCTP support
 for NIC management
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-10-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=1803;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=bwpQIFwpZpzyzjai+JYBYfCrfZUWdhbKBq8cHgvMUjA=;
 b=oDGqxJIBbfZ7/afAwIsvVjkBfZM66AC4NAU3Nl/DKHdHlrLPNSwK60RC1citbXPc1kcm284Lf
 OCMuUPbPXxPBrXRXK9WJqB0/QIZT3wAgnO+MLqFtqts/SAYDRTGtqX1
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add the `mctp-controller` property and MCTP nodes to enable support for
backend NIC management via PLDM over MCTP.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index a6a2dd725266..5fb67ad2d777 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -186,18 +186,23 @@ flash@1 {
 
 &i2c0 {
 	status = "okay";
+	multi-master;
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
 
 	i2c-mux@71 {
 		compatible = "nxp,pca9546";
 		reg = <0x71>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux0ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB0 NIC0 TEMP
 			temperature-sensor@1f {
@@ -214,6 +219,7 @@ i2c0mux0ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB0 NIC1 TEMP
 			temperature-sensor@1f {
@@ -305,12 +311,12 @@ i2c-mux@75 {
 		reg = <0x75>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		i2c-mux-idle-disconnect;
 
 		i2c0mux3ch0: i2c@0 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0>;
+			mctp-controller;
 
 			// IOB1 NIC0 TEMP
 			temperature-sensor@1f {
@@ -327,6 +333,7 @@ i2c0mux3ch2: i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
+			mctp-controller;
 
 			// IOB1 NIC1 TEMP
 			temperature-sensor@1f {

-- 
2.31.1


