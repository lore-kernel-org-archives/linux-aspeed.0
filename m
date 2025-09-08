Return-Path: <linux-aspeed+bounces-2175-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9C9CAC582
	for <linux-aspeed@archiver.kernel.org>; Tue,  9 Sep 2025 00:34:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cLPvt07CSz2yVP;
	Tue,  9 Sep 2025 10:34:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757318555;
	cv=none; b=J2cwQYaDS6opg+dtHwdvw5G7N/2mwGeoQj26mfjte+4GwUhJ11aXkESS5CwRLTeEvAcK5c1mgiGoI5XV4J6L0JSKeX1DaaEl4VOBCUx14gFIPeVQ90G7J5Jh4n86ro8Bi74sEif0SnPq3OdE9DS5VPkolOmWlyy1mWFl60fK6fe6bHKXOWgIc8ODsOHaXKMhi8rdjsUCjVD/hjSZem6OWq4iX/V15G6P5yHq7Xx6m+LcYGQfYVRIpLQ35iezHDzl80VX1VlNqETAeZAE4DskqIZgRBFwum+MIlljjCvqE2n4k2whL1OzbC/WjpWiid/+ihOS5YokDXE/KHA0xcf+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757318555; c=relaxed/relaxed;
	bh=d6xgaogVQKQX2VRV+ySbrwbZYS0YU53xZ1QdE3tIb0k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDQt+2u1n02HkLSwtDRwIJuiBVgSQu2qIXf8TgxAVokU+9/87QgFGrSLNOJyi/0g39vZJAE1FUX3BHSAe3veEsHGVZ72P9THs0lzIblDIcfOxkNKvoGh84nua/IG0QVRWXmVbuLkihjy5AUoerfS9GcwGiPuDgAt0NpfcR5GRJvNlSxEXx9DqTwEY6eAddIyQff/5tIBKbKmELHZOwKHPpP8yLCaDv18Bpbk5fBUBmQ3dXoi/tDOQtnCXJfASC6e2bshmC8ODrg90XAAuYlzEUzg0OjmHMU2cUnYxg9TDs4F8LUlpiMdv5mzE76J1QNKT/GfqGQ3sA/CQdwfLcQbfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z0OZ2Z2F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z0OZ2Z2F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cKzvZ5Sw4z2xPy
	for <linux-aspeed@lists.ozlabs.org>; Mon,  8 Sep 2025 18:02:34 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7725de6b57dso4757011b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Sep 2025 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318552; x=1757923352; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d6xgaogVQKQX2VRV+ySbrwbZYS0YU53xZ1QdE3tIb0k=;
        b=Z0OZ2Z2FBW0TpJ2smm8HZTdQe991Hwh6dLqkZdog3OjpgN+LU8RE6ThVTw9WjylZkT
         jAl441AnA8z1OAsghlC4N0QThIdS09dTUcv6CWEG7YM+6K4caAnyzUpgGZVrqTQMsbk4
         LiNxsOG2xxpFXfykj7ECDTWc2uhcUW4MrkLgyx0/JJNEazewVXoH2TDSIxi2BQL8y96+
         wFg029EQxIqqMdgh6DWJWeRzaioQD6srfTnK0HzkXXe/cOP0z/tbTZsfRTo0d3yzIYwZ
         b2wzzikTmnfSVmRcmPNmADRizj278+oUoEA7Up3qC/+jy5jswnpvLduJHXbTwHF4Y6+S
         AZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318552; x=1757923352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6xgaogVQKQX2VRV+ySbrwbZYS0YU53xZ1QdE3tIb0k=;
        b=ty2ByijHV4hn/VPkwIF7st8CI3BHIMAQEs4kHehGXBH362W1F8XW+TTVV0/B/6G31G
         UV5QbuAUT/K4bYRN0iyA5VomxgfJKwWDkA/Rv091II9rd4D0o2bvKktfaqjsbaJwFO2q
         zSo4x7Y/uIC1+dNP6Zw/ZwALNiWh1VLDLnh6UrBvHdVJzkbKzZfSVGehfjL7rEs1aYxt
         TZWlV8+9P6WFmr/DguAAd4R0TP/xZeX4amFtgJU3UYjS3XaSgnpoEGG5aOkk0b7qKGeh
         8YeFGxuPR8Z68sWRFL8vEF8ud8yUZzSQf+FuGvc0Mv+3S0idGUt7PBZGUxOzPmgTNyzR
         GTHA==
X-Forwarded-Encrypted: i=1; AJvYcCUpitwJ7/lKCiZURwF5fp5kryQFpfTv5lF66K2QYh1O3lyo22gjrP3l5w6wCwRRRVAi09gEHJTRpcm7dt8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyLalbTDagJOoqjMZj2dMFxytIeH34FOFypLd4popRtG1UR2if4
	/IUDA8jaMWP5O4NhekVrft20/PeWsyGYtaJK2sEV26nXw7JTfvSnpLTuiO2ANg==
X-Gm-Gg: ASbGncttrUh459ouhYBsBCCnrxZW0Ps+GUcKQC9gfja7KUTSAhcIhwsGPHh7XtLkgtC
	6rlRuuOzgy44hOMxmQmxk4M1jBCB7Iz7/qE868qHcCkMcSB5IwiZABfTgzCmWrK7yMIha5LOSuj
	e0rVkDMeTPA09lVsEqwRRz7bMG0XdnCSmgVpyQ++6UZpZviMqja8pmj+mX45ah/+nk+lwQXuNdR
	LTz+wuVVZCAfOHsfPpFSiJ19nNAm1eQEIC16BPeqUrEsret9wtGXdsbfVdxzvsMBhPrYoAEMs5V
	mgM+Ona8IFCXQvAgV13+EJtrWpl4TwN6kSSOnaNtoToVeQRttY2smetZFzNSwoNRaexN0OBxq0H
	rtYH8AFqvn0I29/+5stwXWEUIhJQNNmu8/e6C7naMzrgb4j76Yhkw3gr7I0VJ4Urzn6/do51mel
	DxptSt0aRH7GmtTEMAHB79Orts5mDsSE/igtPQlHTX9NYUyBOpyxiz++AUkL/goXPxV1A=
X-Google-Smtp-Source: AGHT+IG/RzH8Pp7y0ft2xmHf4XmY2h/VHUbNeQ55YY0ob+wos3GdVYgnpsB9e0HRduW0lDHzKpD69A==
X-Received: by 2002:a05:6a00:2e11:b0:771:ead8:dcdb with SMTP id d2e1a72fcca58-7742dda40e5mr9781984b3a.8.1757318552056;
        Mon, 08 Sep 2025 01:02:32 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:31 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
Date: Mon,  8 Sep 2025 16:02:13 +0800
Message-ID: <20250908080220.698158-3-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add the mctp-controller property and MCTP node to enable frontend NIC
management via PLDM over MCTP.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 2f5712e9ba9f..a453f8dc6b36 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1248,8 +1248,15 @@ temperature-sensor@49 {
 };
 
 &i2c11 {
+	multi-master;
+	mctp-controller;
 	status = "okay";
 
+	mctp@10 {
+		compatible = "mctp-i2c-controller";
+		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
+	};
+
 	// OCP NIC TEMP
 	temperature-sensor@1f {
 		compatible = "ti,tmp421";
-- 
2.49.0


