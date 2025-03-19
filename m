Return-Path: <linux-aspeed+bounces-1066-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA7BC36000
	for <linux-aspeed@archiver.kernel.org>; Wed, 19 Mar 2025 16:50:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHvny5FdXz2yfD;
	Thu, 20 Mar 2025 03:49:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742402998;
	cv=none; b=ex1K0uRiH8d4RRjU8Pl3lmsuzOFHkNzwbbBpwxilz/PLnGuBNZwYhY2yGUkn17KCpI42zWusTaAM31kLYVbN1UcrDV6nz9/JznQiBXAKgMiP9I7xORjuUPUPC7rFg6QzYZM3fMgz59Bt5GmjSF6WEFCUj+q0JSzlndQ64CzNstA91V/UyJt+W4TkKr4lRkO3AXaUXHI1Mer9FO0PqNkz3mVqaqnSvZxbTm7LtvRg5oWON4i+TPCbDRgjuYy6M74xnT14D2L8/g9i3y+Tym2eEFWoCgf2yzxy/zYJDEO90fHJLjiJmMong/LBoeRxhxnVCC1dRlAK6mHtnglDjQ4FsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742402998; c=relaxed/relaxed;
	bh=GKG4u8A4SwXbQSgAOY6y+lFBx/PwI+3PG5TQ/aiiLzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTpqGrpf62o7t4YYpenkPYS9VJus/MBIlfVj1Fs3A1X+uc4kaQ0PcFyGdiaHkOUAGcKimpFB+xp8kJ5f3a4URHaU21c2MrhnNug1TIRslBFsn7pBzJvjRQjNuknNI0VEXh++gQksln3HJc6tO3GtLaKT0ClZoWKnFftlwFTByuM8NsetIFDJPsJko8obOGckYy3HcwwmkS0N5GDvdJxA5jershX+ooF++/23S37L19nW+3dpptox82NZW0+HND4S8ZtKa0va0ynJvBJbXbkA2d1sePUTeMtisQdcqDpN/9nTFUBuNYJDpSqXmSD7ElCbl8jA9Mv1Sf4osYNsZ/HDlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hVRYYzHF; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hVRYYzHF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHvny02Lkz2xGw
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Mar 2025 03:49:57 +1100 (AEDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-30185d00446so1543242a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Mar 2025 09:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742402996; x=1743007796; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKG4u8A4SwXbQSgAOY6y+lFBx/PwI+3PG5TQ/aiiLzs=;
        b=hVRYYzHFLVOjNE139U+fI0/hiZNzpWiYyF1MLDYHqymRF/P2bEi2dh4YKswG80EYLc
         QZgP4xXjBoKX2f98CvLOMd7U93lHsEdC/hMvfINn9afQNc3ZdCwlAtNuaQGPBzsu2uif
         fJzjymjvJVHpjSSl+yK2vwelGXOCDoawFlzju1Wi5zf1P+GwzNHqvr6edsmvKOsljqIb
         +7BaurRRjmmpXqMGAMkyhn5kCs4MTZB7KftazGIw4EVwQFkT/gAB2FsfHx8kGDwqzoGA
         SfmKjJoIn7osXxJgvoCcsJWqn6lonSR8s+d0+F5kkCU4tewV5jDspg5KfhJ6x4jAHODn
         yQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402996; x=1743007796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKG4u8A4SwXbQSgAOY6y+lFBx/PwI+3PG5TQ/aiiLzs=;
        b=ON0rOUj/7ExME2RAcN+ndhiOXUFGLUhpG75OvAr5txvgcGhIQOd4QIwhRAwUB+1wEr
         11bOxTb0WFWBbXR3+/T4KooyAsiX6B3crBrHmA5qMucI/KwqYHH6nlhNXo/HBP6/nq0x
         MNuc/RePuxwoEv87vZDP24E7ANh2zltqr0d9Mew3zXZzZ2vD6lP4m23ItpP4ulM3Tj9+
         5XVPolo/f9YMufkJcrRRe0rg8TbJbdZru0wb6Yg4sZI0zIgNA9fN5KvWS0kQ7Vcbm67h
         AmQKeB1MTS032YYVup/X5+gcDL0HGXmI2RwQVu2u1uOoRpKVofyKIU8AXKSRR48gRP/d
         6jNA==
X-Forwarded-Encrypted: i=1; AJvYcCV2+Z6krMGsqJdLP1AqB6NNCqtJmvguC8q+eX8PUJEhV0J64QYrcAvqTTQRIzvQ7Sp5C3JjxTl9W1HMCYw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw6CnOrSBB+G4jhgp4ua8x6B9Wzb5xcUXnJqs/nLzV+CRR851XT
	iKnuAAKSr3HPsrrtJEBNl5OXRjqKE9clbu9/APYsNh1EoARPc+MXGynOzg==
X-Gm-Gg: ASbGncuc/QrFro69MJ4OEINmZ9oqY88FcyZDjYhlAjHApgfnA3jv9wSwKbVB55pqm5g
	br93oa6TFjVOTBHmLabU7RNnvXAqq+ONM8v3aNYjAz7vy6r89N0v7lOQbZsdaqv6KpwQvr5vW//
	hROlIKAELIIqP1LiCcpMNIJR5ioz7nkGEloZsy2JHr5OFTx7NHpoI6/vNSB2fWUYn+XSwyybtdb
	CivbLGdT6p3KSP+cO80vcgLxY2IWKi3T753vWbtTc02WhuDKGrg5CFN2ZbXQrWrIadGdhDa1gV/
	bEA5lxAMqN+dTAhWmGpbcs++Lh8RMNUv9BDLZXd2rTqhCFV0qLlYiAQ6VS020t+pJqcvS5MWIss
	oU3pFD1MjLZ/Xl1J6BHRNHQ==
X-Google-Smtp-Source: AGHT+IHXOOKStoICqG32yq4k+0zjuAzQYQG0OOTXhcrihQzKdjTydmDVvm5dRZt9HcYJZxFVF2KMew==
X-Received: by 2002:a17:90b:3b85:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-301d4347069mr260059a91.16.1742402996048;
        Wed, 19 Mar 2025 09:49:56 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf576bc2sm1863641a91.5.2025.03.19.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 09:49:55 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 20 Mar 2025 00:47:23 +0800
Subject: [PATCH v4 2/8] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
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
Message-Id: <20250320-potin-catalina-dts-update-20250102-v4-2-7c34b8139014@gmail.com>
References: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
In-Reply-To: <20250320-potin-catalina-dts-update-20250102-v4-0-7c34b8139014@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742402988; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=zCunrY7p7KNDC0DPGI2jLsy48dXqjOJ/Du+Sxdf5cv4=;
 b=9D0KNCjX8ehQysgIdjsN16NEt0i08PbfBxhgEMOjbhQ+DTyazPtj/x3cGXMaPtIG56s+SGB6y
 7DEKQ5ZIodiCYC2wfTjMv7QnfQvCsYrZHHlrymllNEmwjsOTT53W2fh
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a remote thermal sensor node for the Front IO board in the Catalina
platform device tree. This sensor enables monitoring of the inlet
temperature.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index 75c3906d9654..b9a7654325f0 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -604,6 +604,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

-- 
2.31.1


