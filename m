Return-Path: <linux-aspeed+bounces-4079-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8CFCD4F4A
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 23:52:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKF2N1sdBz3bqy;
	Tue, 19 May 2026 09:51:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779092029;
	cv=none; b=WtW1wtVw2/TIDsoNPXDYrJe08obdLRlTW9/a3RMqqO7adpEGog+nXoEkG9QgbRE9RqUxfiJ1Q/dHAmtIYFIje7gKY6DxqObbJ/vMwjWbjlv7FNRWkRYgMiRrnQVWFhAmeoVDGZqHb3+i56wut/OgYOfiEJW1wjAYnCuQUZwE5HO7Iphlh9lzCYrUwPbqkCvuJtudxoQRGbeMtlORf9KP/pe3PCBsgUAL8Qf1dSXOhjJ4MRARL0PUg3r8fPcaBtI4iZWn/CgEvgYT4/PAVQvbCfe726T/MunTdg6CYBkMicWX+3H1cXYY61QHmIWIEnJqqWJ+6dDVajAbhi42mOqRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779092029; c=relaxed/relaxed;
	bh=HR4Kjt+Vrl/yVgY170pfdcB9p9LiTbCCTUEcbYkBEOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUP31upFOMHzhc9gmLzGOWqjrqdPASDrkgTQyVXBHXoQr/I/KFEWwluDjjwUvui/hpnns+vb4gsaPqlV4hlz+D4QNGdBtnN+gKVKT/L8yVmmuogsxbmeSerrYIla38crS0NrOfB+/zu1i9HQxoboxj8aBI6ibOKHjfp3L/HhjBb5XWKB8JUJvutoAWP1si3YmQ2VkyOeIzsFO78kmz7JDWf56U8jRhtYHDC6SE588SsG2M7IiLvddXdI1YpI9Eckhm9KKv6LjMLjVuhIOCHYCh1YPFUT90RLDCJDs7OJpmhubWAn/clHc0VPyGndtOC9zAAZM2/0TAGfpKxG6cpxWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DE3EpFI1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=neilcheng0417@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DE3EpFI1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=neilcheng0417@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJrDD3dzRz3br3
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 18:13:48 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c80227c9572so770181a12.2
        for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779092026; x=1779696826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR4Kjt+Vrl/yVgY170pfdcB9p9LiTbCCTUEcbYkBEOU=;
        b=DE3EpFI1/UTWOjibaDJDMePNzDqE8QGnk7OGskHgmuJlHI6Z86f9lWU8NSY3Uxc0E3
         KlqfopHGspaV+cs82Un+Ylm9RG7d+fZTyp188b//UfhGgHXvhjqzbgnBs6BpZfOJAIJQ
         flQT6ldiSxWmR4uI0PukGxkNKPZxkfsZsMP5ltlKyhy+PJZji3uhPCAniIbmPpDy74GN
         RZ7f7tMICMNoX5fuE4CmEXW6m9sHuZdsR4flSSchK7Il3b3MbKqOlKI4qj/k2DqOSaAf
         w6N96OhEqgux93jTupldzonemQaGVrIdX+vXqDlcc4B6vvQ9p+FKZQiq4hsr0ufZ/FBC
         kevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779092026; x=1779696826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HR4Kjt+Vrl/yVgY170pfdcB9p9LiTbCCTUEcbYkBEOU=;
        b=ArfnxqLxNt7We2Rec4SYUJmo/qZ2YJdHHK2APMbOAJjNYH+pOsyjwreKv7N4cPA9XQ
         bWgS35j3+ilLIDd9nMXetuv7Dmu/EyJW0pjF3t95pNKvg0p4mi6AV3i1QL4vduJ4SLwi
         eJAgdPtjLH84OwWiyV5THMFqMg66yvpIq2PCdcvQrv9u2JXwNfx1dTgeuxdpvFLpLhsN
         uZlu5ymjRqCtyql9nOQbgvxk/C0AorlOrql0BNag3egwCojCuixeaP0sH3SbdB2mAyvc
         d2EFOxXe5lj0dwSjMvFfFoeXY535fUng6p3EStqyC/iY30FtZERW0gchr/cW+B8AWBZp
         uN7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8/j7n0UlwBSKepkTEu+CQrp2NWrvJy3kzpxF1IbcOL+GUf0d5OIhmMs5v2Sh53XI3yR0GdmZIAEWm41Oo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3pVL6JiatPQEUTu4+jbVDM6qjPRKLzSuwBEblhRjFvn3RloBX
	UeBCH9k5dNTJZy7qY9t/Ykzro4Sh+ysKF5shpH0YabdbYcaT0M8zJqz2
X-Gm-Gg: Acq92OGqqk+YyyJtVL3FJOKx9Xkpdom/m8p/VJ3hQtduDy5pGKmFd5SzMZG3dRyszfK
	lONA+lO6AV40DwkSTZZxegpvDz/mb/6Ts+Kp/SEzvMAtkABsD0hXIMuouWHwal3TWjqWo5jlYym
	sNg9bWHUbAIMFxDqidOJmH3XWXs/FAeeUTJabasiwPCtp3fQ3mifZ+RS0uZWTLGHw/eg2UglwH6
	JtCJbIFYf4Z/M7kzqLt/UEIC2E6VPLRDq5boP5j7UpBwwOKv5zRJLBJTR415hvQXH+hJ7n2I0/Z
	DeuiQd/2JTjQXfUztOuvImg/ByymuuNP4raAsgz9hmpraEqHKFvctC68Bcub+5o0HekGFdvzp5X
	6tfCHPzcRxpPU3nazRZjPWNJUCA4ly34hkxS1PBoOHJLlHk2Ztea3qoeWQJuaT6OS3JWR0WnBep
	ySoTRgOO+f3U7zcsoBgvmkhBpvEKmqwUlmnuueR5C+wYAaaN15yxzBOikH2xICPo+7Www1KuILo
	151PFs/IaYBeA==
X-Received: by 2002:a05:6a20:7d9d:b0:3a3:2b7e:a4ab with SMTP id adf61e73a8af0-3b22ec60b53mr15472490637.44.1779092026391;
        Mon, 18 May 2026 01:13:46 -0700 (PDT)
Received: from open.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb100706sm12749462a12.17.2026.05.18.01.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 01:13:45 -0700 (PDT)
From: Neil Cheng <neilcheng0417@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Neil Cheng <neilcheng0417@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: Add Meta Rainiera6 board
Date: Mon, 18 May 2026 16:13:24 +0800
Message-Id: <4f7aee0a2dfc44770347ccc82e54820e7b35317c.1779088499.git.neilcheng0417@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1779088499.git.neilcheng0417@gmail.com>
References: <cover.1779088499.git.neilcheng0417@gmail.com>
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

Document the new compatibles used on Meta Rainiera6.

Signed-off-by: Neil Cheng <neilcheng0417@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 8ec7a3e74a21..1a2252eb08f1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -95,6 +95,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,rainiera6-bmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
-- 
2.25.1


