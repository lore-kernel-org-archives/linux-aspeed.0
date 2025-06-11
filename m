Return-Path: <linux-aspeed+bounces-1390-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815D5C71136
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 00:02:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHjNx72YQz30VV;
	Thu, 12 Jun 2025 10:01:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749641345;
	cv=none; b=RgXzSS4kdsojniUTewAksmidTpielhK9qxhaTRyDQ8SEAYmfy7KPkUeo6yKrP0Ns/SAFwHjuQeiyQxm5wKPse8b8c2dh0YaE7Gh2iZJhq+6xXJNn99lQ4N+MAlMaWN4zKPPgO1K5BWot5WxyTbFu44IGVdyS1trEiCupxid3uBARF74Z6Ee2wQ+6aTRJYdDct+hBQgiTXEQlCd0LxzFlM/eVGEn/jGYUbLXFzZeFdHBWGNX11TvVcnmEVRBixv9zVYhjEGJpFbKWTg8WchgSxRC+BpDSydGueO11IIswfr0kxfgX+S2BCSLxJYBawalshOwbEFexGrVCvTJzsdYNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749641345; c=relaxed/relaxed;
	bh=wi7qs6/0obufZNyEqVTYOnyqV5ylPNwI/dhWbrEmSr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EqfvX4fkeU0DYIghn/ZZDuEV8EMyxiygrIQu66YjjBA48Bfm6ks6H/79EL3YkNICSAUOfikfky77MNO2ZLtIrliyeutFfOkyzbrcyVy0Pv6V/TIlS5XpgboWN8tUKlmUPlS82p3Yl2SKJbqOnvEvLxAC8CdOH6WQAtyjQ04+rthV95bN6pU1PlC91hFvj2gyr+waPAuZohKmpYcnCPqKL2vNLDh+/CpAy8CdQCmcZvpjlW333Ovs8e4ZSTppVJFb9wIfPzKHHyUd0zPjgE/WNPABNrAsb08zF+8e8w/2F47I8WCz4HWjc8jLR9nofZy/vSjdKuTNqNp/E717W/PKsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OA9PXYw+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OA9PXYw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHNhx0QKMz30CB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 21:29:04 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-b2f603b0f0dso3922957a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641343; x=1750246143; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wi7qs6/0obufZNyEqVTYOnyqV5ylPNwI/dhWbrEmSr0=;
        b=OA9PXYw+e8+XAAQssVVHAL6DCjhUKOjLOPe60wYq268Dd/NNPTdSEVMfW9qx5tEhn5
         nqK6/OOW0IMYLHIcNa56coPd+3VwatiAC4oQbrxMieRAgpmOKot1X1s4UbUwL4eJJ8wh
         JUdR3aOaE50DABlr51zBR/VdWkA0SbeiCmSCVM91s5It0Xmqf+3YlYSZ/Ls4DQMoJAO+
         CwMr68Vpw12QOeehqz/05hDq1vn/OFjjXzePQYImL0lCSxkn7l3I33W9Eh3antX9PxZw
         2FagZOrKvds8rxpJOtOS8dReAx/h76ueJWIzt6aeLPulfdeDb3mJviCUA8aGaRJ0jtcJ
         zqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641343; x=1750246143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wi7qs6/0obufZNyEqVTYOnyqV5ylPNwI/dhWbrEmSr0=;
        b=kO9Es6KKq0C3iZm70pCynfnUy4Z9viGF0Z/TxRnnjNSeQXoYSPyflMHs2rlLBe7aTe
         36VpGrombvQ2q4BSjnpNjqzsN2hWzqkglAY6keLnQ0Z53fOLVAsszNlxbY5uhLQ3YO80
         LaFdWginOLRjZPWljPcBGItF/V35UeuUfMq60tl0zcTLVy2LQYWZT8nSYiwZ+D+APfwa
         n1ksCJs6ef0USaWzHJL0mRma9ARBv4wb0NhP2oLxXemHgLYt4sgI8yS8RV1yRs2moJXu
         nMqPSxZMFn9egmeX38R/Qbs2qpcF8kHi1fZgqzQeGLQouNZPk9lP6F5EK/iHLmAS/8X1
         7M6A==
X-Forwarded-Encrypted: i=1; AJvYcCXE5uhon32aH2Cqgets3OA8UHqFE5D9lbToxv7do0LEyQ85i3RgxZjzcFD8Bu+FhCkjJMvIaUhZudDPHo0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyryWyVVNj11yF8ye3O9oA/D/jRh+IArWWnv7fsuK6iY+YBf7Dc
	SIprgQXBmHLQX8f8mFgLXta9k6XmwU/t9J2xOkSHWlN13O49wjrh8Lp8
X-Gm-Gg: ASbGncvGqsKK3+zbnWpSRIFst6WosWsq1InG6zRejeoZ5FyucxjMZ2gigxDMNX7fldv
	kDAkqxYYj4kjWr8x/qGbguCjHKlNSHTJkr1HpfjiK0hBjYV4/Zut2d2lMnLXC2wa0ouUQFw4eZl
	sV1RogL6BDFcKEg9vyh+3Ge/+KRJ6/GqzThT6ldLL4cs9hXD7yGdBeqd4wHO/NoNGRmHgojBw9O
	6WEwWSZzcoXtOw/j6BkJunZ/okb3tfYoX9+88CcZ43oo9Z6m0DGxR7Q/25KaaOkbcwQl+VxzLyX
	vpZstD4GToTZU5wIAmh0aHDNcHNkDcfz57C5O2l9aYHf907gsSK5aKMI1KF0lBuXZ0IXf3BB2Uw
	gNHj6weYBr0Sa6Rf9UT/+25cG3tYDQEW4TzL1RXJhfwhBwKdxiGtBWeuPE3IXJdTNAaCo7j+o2G
	w=
X-Google-Smtp-Source: AGHT+IHMjJzse7RRflhgsuTZl0mG2rLFTpa3QofIjn2JTX+BYAKzHeTEV28/i1Cf1ihDW7WbHff7Cg==
X-Received: by 2002:a17:90b:582b:b0:311:cc4e:516b with SMTP id 98e67ed59e1d1-313af28e377mr3594748a91.32.1749641342638;
        Wed, 11 Jun 2025 04:29:02 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b1fee63asm1082246a91.3.2025.06.11.04.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:29:02 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jasonhell19@gmail.com>
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Wed, 11 Jun 2025 19:26:49 +0800
Message-Id: <20250611112650.595554-2-jasonhell19@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611112650.595554-1-jasonhell19@gmail.com>
References: <20250611112650.595554-1-jasonhell19@gmail.com>
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

Document the new compatibles used on Meta Ventura.

Signed-off-by: Jason Hsu <jasonhell19@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fb..a86b411df9a5 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -87,6 +87,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
--
2.34.1


