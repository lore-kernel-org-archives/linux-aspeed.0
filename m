Return-Path: <linux-aspeed+bounces-3129-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB8BD6406E
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ5D4TPYz2ySq;
	Wed, 17 Dec 2025 13:43:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939408;
	cv=none; b=InAxZSlZAaM/X2IyDDwa9Zsbtg7dlD2IWrxRnvVgAkMMJXII+tvObRtkHLkuxeL9Cir7vlxbJpHxPLn+svCzsWu58+ZoPYU7l22u0sEjLVy3HmAkmX7vpA0iIHUnY/ciIgxRgONAW+FGm+8WmW8OCKx5g0CAhTw3G4t09eDIP//NdPzBs6bst7PThwhinPQPJ5iQsiu2xxAjIHUDf9rnHKjZdB5TXGZxDlHPoLYqlRZMr+dYvmhlrC0ucG9RrtK8chn9bt5tpd2stIz7h3rIxnZfnWphD8CU9VxUlrU8R5UUduT4a9rJ9cMQ2O/L9ImHz08tHojENFA1oeu+gKJZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939408; c=relaxed/relaxed;
	bh=5KMCfTLhRPCYocCD5Sa4l3D1sRENu2ZmKQ37zZUrHyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2ifQXnQ5rsviNnpotZK9LyDibefvS/52B3+WMI0L+RZMxtJBAlaVK5OQrjp1ZuzS150Q+8BF6AKHFBq0YGnIBcBw7hYhO77feTlEkBWK9p3fGSPxfsn7aYq/p1EAfSrpeiN7h1n1rvGMB4Bk8GfqLG0Aqtr7EJe4BXOTjWsx59J3hvy4KyhUYIc0H6qGNIBds6bxLzVvKtQhsZmWyoce9Tnp0XUHWUnB27xMgryi4sDRMrO1S4iOFHZ1GOiP/TUEvi+UKZp8CBKZafb1gHIuwxjTinFfy9cEOWb3Dinab5/tBEZOXcOQn+RDxPzfuZMrubggq639UUJyMexRQfmOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2kshM/Y; dkim-atps=neutral; spf=pass (client-ip=209.85.210.180; helo=mail-pf1-f180.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=i2kshM/Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.180; helo=mail-pf1-f180.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ5D0CWQz2ySj
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:28 +1100 (AEDT)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso5655420b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939346; x=1766544146; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KMCfTLhRPCYocCD5Sa4l3D1sRENu2ZmKQ37zZUrHyM=;
        b=i2kshM/YMOLkoch4rccQ9nFgq6zjoOix2qyxLa9mDaDVf/YfnaRkBsINTvnCX/H6LJ
         4MmC3iq1Wf9+ETNW+AyCrP97p/zHLS7fz0eEV10ldb0ZTy90gTAVsBwy89gEa4SyRqpI
         L4YzhK/4fspF6qmN7O7uRSnULgFOsBaWqKDd/Nf+rEZKpAI06j/tLKeqaDSkEzK63TIk
         QS2ugHWVmZW/UH3juN/qAKjdmUHTVCFOCIS9chOojwtOaWYd4WrBSIKJ8iqwmIjpDyn8
         x9ri6GMvafRYvouq8PHIyn3xHV64sA6olLJiWBFPYUidOaMb5U3Fbzg64yTss7ZtPhAO
         +vqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939346; x=1766544146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5KMCfTLhRPCYocCD5Sa4l3D1sRENu2ZmKQ37zZUrHyM=;
        b=IWfZLuz2r/kd31/N2oJU+sgaDxnz+1neMj9asn3p/tMtibh1NoptcVbEkYULwECIoI
         IpJs4wLadQ69mEw//Dq1CjJFquXJIfP5hXlNpgQnQ9WQQe1NFpPD6AAiV05zt+GKcHIu
         QefPzWy/1Thxue2nQqWtQhqciOsGyParUfudGyXIqiWN0vDM5pvVHdu3oRbzEvlfEl7v
         VfLEXmLIdPDPVLsr/YzK3bgGw2LWt0e4AL5YjkrwNFe7tVsMcfEEI29RGkKQjW5HLoC6
         0ubkyyPU60UzlFU8R2p4NoGVYo7No5eZywpC+aV5iXtwwnIcVib5hKTsnpWNk3H2Poyh
         ZH0w==
X-Forwarded-Encrypted: i=1; AJvYcCUUX6/pXMc3yxn9s3Y9FyvvG7H+/l0qDhPMuxvajxS6j8E8OiWo3/TT2lbC/19FORsW8zyC7N9jU6le2WQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxDbVvxTI7Mls9IC+WOmtatHQv4cD0tiZvqMvNYF9HTSm6twfns
	cDORkQR331nf/YJmD++a5PSKlfJOh6kPu/BhuvbQudRKIA0nOm7bXmJJ1jYrmw==
X-Gm-Gg: AY/fxX7qsz0JPl+cfVvTwMp0dWTIPbZtemVjQdCUtFAeuwhpsL6/nQIUoClwnHsimm6
	vnjC2Pz0GO9Dcc4P3zziBkq72wif8IPWV8Kb83QHtlkNtwdbXEGJfEdGexadIo2gWLcRZ3Znz/W
	QofrU+6KYINRUCrN6fDVOyHiAN3u8qrZN1pAhJfOR0TbS9oWWaCIhbnMNZryKPtaQP+4Vr1Chsp
	9hHkXJrMKSTRRNDdkptwJeMQuuiJNG7f6axgCBopeWQYJ03vDNUSAvtcb1HAt0LZHWShwQC5Rz4
	EfU0k3g48QV73QOICjDzVqUaOquo8nqXxHa8Zz3VWH/OPg9v3apxZNzA0Uaf08F3UfqjnVaQput
	CJ3EMiegHM6ZIwAV9HsDHNCjln8WXgL3fS5V8FJFci1fEQXiQxIwN49R6eqU/Yw6Rvym6L+AaiM
	nvMU68wKHeq9Fl9YQfXIZlXs5LZsjFGvyaBK9hTQhH+NcIquRVxLmqQgf4QDgKaWLQ2Brgdjabs
	1ycyb+2PCZdUR0=
X-Google-Smtp-Source: AGHT+IFxLVoztRFrvzcQi+RXpwRMMUWexU05bJJDnAS8n7MfeA0BGia80wGlDQVbtEkO9IYQg3sFkA==
X-Received: by 2002:a05:6a00:b904:b0:7b8:87e1:a62c with SMTP id d2e1a72fcca58-7f6702be6e7mr13723830b3a.31.1765939346329;
        Tue, 16 Dec 2025 18:42:26 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:26 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 4/5] ARM: dts: aspeed: bletchley: Remove unused i2c13 property
Date: Wed, 17 Dec 2025 10:39:37 +0800
Message-ID: <20251217023938.445721-5-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
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

Remove 'aspeed,hw-timeout-ms' property which is not supported by
the driver and causes dt-schema warnings.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 8df145d2bcfd..123e2d1891f6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -962,7 +962,6 @@ fan_leds: pca9552@67 {
 
 &i2c13 {
 	multi-master;
-	aspeed,hw-timeout-ms = <1000>;
 	status = "okay";
 
 	//USB Debug Connector
-- 
2.43.0


