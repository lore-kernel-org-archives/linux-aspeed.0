Return-Path: <linux-aspeed+bounces-1611-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CFEC83038
	for <linux-aspeed@archiver.kernel.org>; Wed,  2 Jul 2025 05:04:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bX79W1s5Wz30NP;
	Wed,  2 Jul 2025 15:04:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751432671;
	cv=none; b=OCxjVJ3W1cbD0CsyhDmlC3YgvLnxxRKcBAT8T9Rc/TuPI5cxyEmvzqN5vgqSlFx/11UJfAHG3hyPs/Ff9X1/6tRK6a1S+xYObCU6BetHpbXxL9nH5OXblpFSHx9yZqQO8m2T397NYfy7LpXWv9pE3rRGXiIjeJKXWI5a3/Coht/0p2yJPYUdaRg8iS6ixuoWFhw5c38diU1KSHkCjrUIkOpJ4zNagYJ91Mu0MLVMXrHhKYH2/bw4iYNW+Pporg8SUrbzowG9NuDGjS+qVYNDwahGJ7x9eADsh9NIn74zmriFR4gGvns0rbGZPts2/owqPuFZJNXd6z2Tzi37V1aqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751432671; c=relaxed/relaxed;
	bh=QXmso8g2COR1WBKWaY8Z/xRycJZ8eCt0dgwiFP5AhaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLvGmdzzI571xPO41UfmGXQxuXcPwXHRogppWojo0Z6WFuMtYbuviiq+rns5ca7fTzcwvssqqCPjogOdgJWX5tn+e+3OfmyZZRRVSGYqkaIuxgkfhIhBRMdopX397GXlvbuw8zzQVTtaoOkV5GAzfFwGy6Q9YbOJqLfRwGdt7J0nxJfg+kbsRxznjj/64GVT9nGJX5mwHJZRgUtYn5gDNjNlFGbdx+yPnFZ6j56nimJJAgJvwjptjE4JGu3ct88F/PK7kf4/gw1tPd9JKgpCXVZ9ELFmq3Sm4wtSd7epHxKbjfhaYi4xK2sV6E4u6h/LkEpnvPOwq+nDVYVyE9bxlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tf1Ngurd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tf1Ngurd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bX79T6qJ2z2xlQ
	for <linux-aspeed@lists.ozlabs.org>; Wed,  2 Jul 2025 15:04:29 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so5229072a91.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Jul 2025 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751432667; x=1752037467; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXmso8g2COR1WBKWaY8Z/xRycJZ8eCt0dgwiFP5AhaQ=;
        b=Tf1NgurdGgmwwUm2a+U2g+VTnn5dMMLyaDEd3mnycI/OAg0/uW3WHPjW0VqyVMampn
         TXG4mET1zZ6lya/M5C0B34HPVK/ooy6u3jn6vMjTwNB9ywOCXz4KTIgPuITviTDdwEip
         b0IBb/QA9aAMCC/i4InAOrKVbAtA7U+zDTsAf9tAnqWj+fpvXFSqvqeDxm7a4IgNJbHB
         iCJYNgOebUhPMQkIwuwFRgIMLNFwBYbnWovZxwbjSxrOZ/aDZH97wdMKTkiQX03EvDWI
         3Tf+PC+xJLy0lgkQQXyc8sG7yKqDjCrte4isFgbxQPFRXJO6zs/gw6AKB1Orz2GNkWBF
         ce+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751432667; x=1752037467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXmso8g2COR1WBKWaY8Z/xRycJZ8eCt0dgwiFP5AhaQ=;
        b=Hbs/Am/Afr3ybP1UWspoWVLJNielypYXaVaRoXoKZKQxCluamlornYxuCx5YebUt63
         OyufEr7aGZsbu9vcSRCr42HoHfos72otRR2kEBE+7uM/35y+YzOjQNEvL0QV2upBbDrD
         TJ1XmlVfqmMR9xCcSyrzxi92k235DCo2NEsr5cbDU8R3+3yUFjGTh6YlOkQxY4R/1PsM
         9qd/GsiDWsuunXfp62oCGJMM4ByLHiyzvjIfNASK7gO5VvPpM0eCA2zU+s3HxYJ4bQQs
         TfutBD0WGBAv5wD1KI11l9HNJASwCpJUiSYjUNacnXPwsC434DWxmT1C3nrZkVOCA8On
         0HMw==
X-Forwarded-Encrypted: i=1; AJvYcCXmwS9NUfRkkgl6PVDO1/TMv9fbs1YIRu+QJ+Y2Yplp0y3Q66NkXRjGYAocdGcmJrZjW2NLDQxWCyLmHn8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywh+X1sFRxBJ9l0ouGLWaxC/Oq6MGRP8EXaVkMrKofkkHGQQ8Q2
	lGlNoC299Nw/dC88r1eOxvJPgYKRs3oHIofPsQdlWPFFYOPGGHw/amDH
X-Gm-Gg: ASbGncvUD0tI7ys2iPcgzle9fdIRH/HZr6h8MnSAFpGXdOV9RGc3522G4zyP3FM1Med
	BSmOt2ODeqTr5sdiWMYggYzEPXs1oTGOYBtlicg8xz8pZdBWRrz8QfDZEA/YjBXUS3qmPsdQFBl
	HlP9nLrIOaZXhukDZRft8zRSYSb7ziezckmWFLXG7QqOkZLwE8vTh+ygLuZZLy3WBiMv7bmkuwc
	DesmLjbk4rRxp5FmKjgNLx4YQVjq8vqyGLPOuZF61a3lxJ/jGHbU1MXuvFy0bRuBTg30jpSNaDN
	zsiWYsAXO8D0s9RJJO1qJSEGakOfH+LCRU5ihx8KEU0YvfxvOSVP/8ODgl/v5RHjr1V0VdWF0kF
	mTxPfM5635xCgEWPGbks3wSrwy3Kog0YBusnrOO0=
X-Google-Smtp-Source: AGHT+IHUG5YCrucrr/166eG7coq7r8DcPuqMV7G9sKstOJsamQmMYN1ozIbRh3jEQoxq+KuGWSkBRg==
X-Received: by 2002:a17:90b:2812:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31a90bd4786mr2068529a91.21.1751432666963;
        Tue, 01 Jul 2025 22:04:26 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54270a5sm18168323a91.25.2025.07.01.22.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:04:26 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH 1/5] ARM: dts: aspeed: Expand data0 partition in facebook-bmc-flash-layout-128.dtsi
Date: Tue,  1 Jul 2025 22:04:12 -0700
Message-ID: <20250702050421.13729-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702050421.13729-1-rentao.bupt@gmail.com>
References: <20250702050421.13729-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Expand data0 partition to 64MB in facebook-bmc-flash-layout-128.dtsi for
larger persistent storage.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 .../boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
index 7f3652dea550..efd92232cda2 100644
--- a/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
+++ b/arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128.dtsi
@@ -32,19 +32,19 @@ image-meta@f0000 {
 	};
 
 	/*
-	 * FIT image: 119 MB.
+	 * FIT image: 63 MB.
 	 */
 	fit@100000 {
-		reg = <0x100000 0x7700000>;
+		reg = <0x100000 0x3f00000>;
 		label = "fit";
 	};
 
 	/*
-	 * "data0" partition (8MB) is used by Facebook BMC platforms as
+	 * "data0" partition (64MB) is used by Facebook BMC platforms as
 	 * persistent data store.
 	 */
-	data0@7800000 {
-		reg = <0x7800000 0x800000>;
+	data0@4000000 {
+		reg = <0x4000000 0x4000000>;
 		label = "data0";
 	};
 
-- 
2.47.1


