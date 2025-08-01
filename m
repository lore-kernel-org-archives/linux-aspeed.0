Return-Path: <linux-aspeed+bounces-1884-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774F0C87FD2
	for <linux-aspeed@archiver.kernel.org>; Sat,  2 Aug 2025 03:14:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bv7GW1YFhz2yGM;
	Sat,  2 Aug 2025 13:14:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754057501;
	cv=none; b=UZ4xRHBs5wzD0WOY95yY2STH2Paxgfb73VGYoy0x0oAo27h3xKK4mx9T24JbpHjbcPNE5C2MnB+qAmTW9yNZc4hSGgrX3BcZecKa5mVyI3JYI806UPfZFIpMpQxHdQUwr+D7xi9YqUwXXN7ykHCdlQT5qHOurUwDDk2C463vKxqPxa/cQDZhNR0kjAIwZMxlrt7zGmxyOVa0aKFFgkQZbV5kGFbaVtOwMXa1P7S5DCaey35gClFW5uDYS+V8hseQPRSBUQcHVWuUW42LSpNjAlTVj8cowRjsa9hJilI7odPrlXPJzMgrCxzMLAxSp1F+BTo6OtZGFZNS59CVdTES4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754057501; c=relaxed/relaxed;
	bh=JspzBnfUdrapzn9O/Ou8fn1SPXl0+OWwJfskfM4dnh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbZhLbFKyrNleh/ggnl5tpSjv/4llR7BPJs8sNg7Pyl2/yJVhSw2FKft8JXCPC1OgGd57nxQNV/2a+U3NcQqU+pT/4QylfbYDmq8d/zDdNBTHID0pwXldwYTFcI2eZbFtDL/ioEvg3lUd2zYUo83JCwG1MPfrLQpHK3640KTSDvVMNp/Lm8mkkf+31FXEKBApHpoMu7cB69DwzE9ju2mNOIuQcg8EiEdLqmQlJcC/U2VGgW0A1fMOVo2PnBaEZQvQYCGPY1kuj54x0NGGtRSgMH6a/zkCM6ld5r+HnJdBSGnB7oa7HGIhQvAawguuabHsUgL3+XtQLBfruEw0s0twQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q9EsgVj0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q9EsgVj0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btnv05RHjz2yfL
	for <linux-aspeed@lists.ozlabs.org>; Sat,  2 Aug 2025 00:11:40 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-76bdea88e12so585518b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Aug 2025 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754057498; x=1754662298; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JspzBnfUdrapzn9O/Ou8fn1SPXl0+OWwJfskfM4dnh0=;
        b=Q9EsgVj0p6P2Kp+dQux3xlgp1BzQFWheFdfuNsNT8FHrcdblEGyfvEh/r1X6XvsDqO
         u9jkoZjym+VSVttkM02p0Y3hmLDSOI1ss7254cjttfThJn++F3BTnyLlEZTNuU1cv++h
         zQf8rx7x1SrdIxEEUdb0makvHQ6WaEzl0kc1NiJ/PH520npAbvWjYqV1QgVyc7VvoBHB
         JLCvGbwuvH3WTm0SQhr1uBV5334sU+oXuRpGr3VbpB3nmJmWTPERx3gH6I+imN4Tbnb3
         /FNeoeBQkeMQ55CsC0ldeRxrERryjwDlXQjrqIHUDQd4qnbLGeStJ8Ty/r4W/NyACxcy
         KIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057498; x=1754662298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JspzBnfUdrapzn9O/Ou8fn1SPXl0+OWwJfskfM4dnh0=;
        b=IHMfMHmurmDHMHg64avyJ3aQ544TErFjeuoR7i5V5LZ1twaOAa/BL+lHKegX4Yec7P
         ujbEzLfDsrsqtOEa2AjGw/9efZ4T6WYMh/I87cHS9yQ+gBQ2rxXdGPcDhaMZu0SCU01o
         R9gFMrusoknC3Lgw1CjKnc0M1kk3tsCs5KX24kRFSAAq485X3650VEReIUDPuJchQytZ
         KiYuhCSiUgSRKD/7VCJVEv0QxHGHNwWEChFDIW6CDJ5wBW5nImkzDui762ylVVwmqQpL
         D4K0J5dxlJ8qGVjGVIwSyVd/Iiekdcdqxa5FVkxq4+87okmhlSUGarP8SKlt14QMcsvZ
         FKnA==
X-Forwarded-Encrypted: i=1; AJvYcCXynXy2nlU3Lx5Oa0UwVcctuLdmJREypcmVApYi330lmyD/fIr/OXYjWu1TWsfP0fuWEL8qAvZemle/la4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJR7Uw40sSqZvCQMu4sr4IQTFDHVPkpF4Uy/pSyhnEHYzPBd8F
	Wnv8BmeGT1jo2mgtfxOqzSItPBMYYHfwK9Vt2A3a8UKXVtybj1VWWm0K
X-Gm-Gg: ASbGncsxDR+PUNon/xi9Rlus3iO5QdbrCGYmu716OnreeEx3kI8ZejkbsvdicHV2PMy
	/xQeVTtEh6PItBi8eQUxMlZ6yaFiMgiAHlKlu482CmFY/i5UQK34lAE3woldQ+JtMA69V+ZKWCp
	fuZahAhgfd9Nc+XU19gkGYBV881bvpdAz85gjbV1DxwvYot83cOgm4CSEwViA5H4lQF30ucU3dL
	wC/kaZb3dqCEupkGnslwexcBBP8ZEuOmZBTWXOcznEv9LPJcEXZChZSsD4NswY63PL9Au2Dox9z
	VPhV94wR2BHuEy179pqOqgc9rnHClyo9mWLVE59uW+KS6gjSFj9E38reEjoMBh8yOkGvdOgAA4r
	XEjUxS/+27JJC4rwh4X7/WLnjWQi2YnIdUReSFNx/BZq2ZWd0Ko7O7q/SnZEDMtX+mznf15XTN5
	RYVESRVIzk
X-Google-Smtp-Source: AGHT+IFEFWflCdTZ/ecvpU2vVOlz2gwYHJz3TWkpnJ/7/BQFqAXMZ1d0N0k5n4bY1xfidiervKAK7Q==
X-Received: by 2002:a05:6a20:430d:b0:232:cc63:45d8 with SMTP id adf61e73a8af0-23dc0d608d6mr19356658637.20.1754057498342;
        Fri, 01 Aug 2025 07:11:38 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0db0fsm3849984a12.61.2025.08.01.07.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:11:38 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v10 1/2] dt-bindings: arm:aspeed add Meta Ventura board
Date: Fri,  1 Aug 2025 22:11:30 +0800
Message-ID: <20250801141131.2238599-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250801141131.2238599-1-pkleequanta@gmail.com>
References: <20250801141131.2238599-1-pkleequanta@gmail.com>
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

From: "P.K. Lee" <p.k.lee@quantatw.com>

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <p.k.lee@quantatw.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index b3c9d3310d57..8cab682b7bca 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -90,6 +90,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,santabarbara-bmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
-- 
2.43.0


