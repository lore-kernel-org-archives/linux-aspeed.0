Return-Path: <linux-aspeed+bounces-195-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3498E77182
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Dec 2024 13:34:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8D3Q2dZJz30WS;
	Fri, 13 Dec 2024 00:34:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734010482;
	cv=none; b=kYccSVdCNqCbEdlWKyo9Yza5ssM01//hRngt1CtCuleeOpkMk9lTENYSzgNqxyMRHz7oMNU3U2/K9bp6Lyc2r30fzWwl7uYMS81gGfcN8UozbXh+IAAMxm9GdMHrpcZNr7jgoasO2SeWtsjKDQiKU83Rw/iqVKW7UDAGA60IMwOMw9yZbGVgis5uPGfE6JLiABliPofL9eIJEgCb5O4xTD4OYtwUTjO5EKertUchKCMmr2dVe3rbdSW5PVjgENp6nFEOi94ZUZkhD6O7tqpL5BELdj3IH106aSMCJchYaJ+z7R10dsHgA4O8dz7QQq6U8Y3co9HiNFhR6VbBn/jYfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734010482; c=relaxed/relaxed;
	bh=Wf0lUEIsGTnJndimnrt/UOqCv8R701BigsdRuKPieQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D9uShx+AOW/705nX89zsNi9YT1qAdJOZDNAHMwUwkHebwaBRixq06bk9c8QCfD+bJ4dHd8XnfLVMUeLkECvMxG5u5T4M1txA3isSOpCfpYsCs3cJUahVAgFCYFBmalNy2g+pccKYVmcfEEQhV2KLH4TWNjmjPZkk1WvU6J0fG4x7YfLPqHteLYhMULu6+vNHHG4kp6JT+yEj/RlkPI6KFul5VqF88xKihfHiFy9deHZ2BJZvMv4MkPhf3Uxi7nwZ6oKTX/05GZAXwKWgBoYTvM34hdhZplns6QNcA/BgqEbBcAjKswLWiUQwpgwD1p7ray+zQY59+Ny2XSAZD/o5yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RR0pHsb3; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RR0pHsb3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=yangchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8D3P4828z30VL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Dec 2024 00:34:41 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2164b662090so5286495ad.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Dec 2024 05:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734010479; x=1734615279; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf0lUEIsGTnJndimnrt/UOqCv8R701BigsdRuKPieQY=;
        b=RR0pHsb3HBdhuF9FiPSVrhH81jxQEWQX/kiNrtJH4ePHBQN9zeRVA806c9tXk5xA5Z
         5Lmpqij8FnpPlFPsoTgXU4RbzJzS3fmzW+yF/bLbjIVWPk7M6rlgGEhNT1MxXZLA2xqI
         +RQb5IlEcuVpbflVWw6XGh1CtZhXH48j76Yq7CuZTQ5jc9cHR0aN8vpBkf0gwZKwM8Ht
         9J4OZyrW3jW9RejB8XFRtqrc+tZbPj9VucIMVVEXsHHdb2sYRY3QFHf1/G6ld2gJSGko
         KMaXkjc3uefy/k3glhVqKqHZlH/JDxad5Q0PhxdRLyoqWUWmO2RM+HI0rwGOUF6slagQ
         960A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734010479; x=1734615279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wf0lUEIsGTnJndimnrt/UOqCv8R701BigsdRuKPieQY=;
        b=AlCZLgLpgvr0Og5bSyY8MRqwztDEO8TVwK+6GW4tX1ylKu8oV84S2fLd9K2/JB36Yt
         FBiUEm3/c89EwmbaM0IV00BebpMfo1vz/BjkpIObnKmTt9Nwo4eXc+1wU7QsUadJHtOm
         6ufD9gqz6aUAQisCDJQKyonhGUykgcNcIBXQXKelMLoOcYa5e3HYQCNK/IMuviU2uili
         QBYWtYVMCFW1JGaEoJBpKaFtMCfrHjyzgPV6ohMgLUVsJg/qR1VImucEG1vIHj4fqz6N
         5gLzVULg7sqvUCR21Wa6mGm/C1dGDkwk8C4ZxDVfKuCR+9DyiZP+rUe6BS2UX+O9clJ0
         PkbA==
X-Forwarded-Encrypted: i=1; AJvYcCUAzG6uPCFwyfPOAoTjRYzfNs/e81mw9BfTNNnsYy4d47wJjaMhC8xpoOSReDR2MNIMwVKl7jVl8h6KfB8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwlNaatErGPcEGtwrak63hwDQXmNclvUury67hZ8Ao4K2gxOHpa
	lxh7wVE3gVrmQzz6nhoZ4oL4VpGER4x/Lc9ndSlZRmRpWKgXgpg4
X-Gm-Gg: ASbGncuKu9W7aP9nILaF7ojxRSqO8REMedx1qxSO9kliDjhPoCjGBTB30LcJNOWJ5oo
	ez82wyOpa+WiV7qgIn91oelPMFjoOKs3HvqX3mZGxEPBmDYwHreubpxlSoM3+JPN3zQVNxcc80p
	ljUztSjbQrL05pyH6zzuGrQsqzEAPZxlFv12lF9NVlnQn61pp7ij/NIA3zuhuEjwVm5XzmxznYQ
	KNY3k8/8+FELwCRVLyp/UAAwdXNrXeA6UxysmZddYhbfapbtS18KbkOlAq8n0Hlm2ctBYuH1rCI
	iZvE68Tv3cwYdlDh2UQpoMBjnBg5PDpdzshmz7V/1PFFmMzUv+E+ZlG34wsJZpmJFsjF8wIGPbH
	ZSFD/
X-Google-Smtp-Source: AGHT+IG72CSpTzAbD2aJjX7X490Q3VfJnza4dGyLAZeAdhGFBrbCMchjemqwfL5MBOt5N81pQsYWJw==
X-Received: by 2002:a17:902:da86:b0:216:725c:a137 with SMTP id d9443c01a7336-217783c0b13mr109498415ad.28.1734010478887;
        Thu, 12 Dec 2024 05:34:38 -0800 (PST)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2163562a838sm83390165ad.29.2024.12.12.05.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 05:34:38 -0800 (PST)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz,
	amithash@meta.com
Cc: Jerry.Lin@quantatw.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 3/4] ARM: dts: aspeed: minerva: add bmc ready led setting
Date: Thu, 12 Dec 2024 21:32:25 +0800
Message-Id: <20241212133226.342937-4-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
References: <20241212133226.342937-1-yangchen.openbmc@gmail.com>
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
Content-Transfer-Encoding: 8bit

Add GPIO BMC_READY on LED and give it active value and transitory flag.

Signed-off-by: Yang Chen <yangchen.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
index 9cd225ae96cb..7fddbe833cc2 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts
@@ -101,6 +101,11 @@ led-4 {
 			gpios = <&leds_gpio 10 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
+
+		led-5 {
+			label = "bmc_ready_noled";
+			gpios = <&sgpiom0 141 (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
+		};
 	};
 
 	spi_gpio: spi {
-- 
2.34.1


