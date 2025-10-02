Return-Path: <linux-aspeed+bounces-2385-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F736CAC5B8
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Oct 2025 21:38:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cd4sT5gYNz3cj3;
	Fri,  3 Oct 2025 07:38:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::530"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759441085;
	cv=none; b=W+na2+uga2yCeOCUfveMWKx3wY61xl1NlA/3QSrfOGHhUKVDeXyWEO6R0X2BGsYe3nC0kH6Fia8B/PV51QIpa1nwbqBCKXvowy3EiyTmZl0l4J5WMl2Xanlp4TQyPmd3am4v5EhBTUGlKSmgGhFlfkMiieschZOXgyeB8sPLZ19gZebJlmCq7wGBmOJCYajsFnv7JoL+U4SMImjSo+c3Fbc5nVqiCZF+ydDMIuJHuK8Svg8Y2WUrEsuWm9/veAn1RhTwHCOfcDvqlGj74AfT7BJ2EitZ8tYkXWyIsaHqRBpM3U1oeIrO5J76eRP6cRXXjSubBugyR4fJPfKXDhd2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759441085; c=relaxed/relaxed;
	bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJEmDqY1q4FmrTdbRtuKIX+VOnBowcNlpt1JIC4UB5sNn25c//XHxip3QBl1F4JD6saaoe/mrvMCrnguD9gwDpsOk96o+D4zBUYkigdS4W4+HevS897P3KQoPJEuGRSWf94kViIa8XgFkOY0/lFr3FPcafRI7HFNWXryvU42aEsgUdW5ME+O+aY9ITivMJQg9BZwvhvJkQvogNHdCYHxez6o9HylNlQPtI+XZudJPgc9ACo27ePVUXGr1HloqqznmLQM9MyJKb95o2CG1YgAXcRRzmSLHBGmgBHvaiPR1TFIDrGjnHrSgUEMyYH1g2f51DFlXRKXvNvFk4S4Ksq6nA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DVehh11P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DVehh11P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cd4sS0rPlz3chb
	for <linux-aspeed@lists.ozlabs.org>; Fri,  3 Oct 2025 07:38:03 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so1128103a12.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Oct 2025 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441080; x=1760045880; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=DVehh11PpxQuzWmbO9RgbsQNm6cyXg3v4L+8XY+TwwNG0DV7fUsXK6VIqEf1uPlyVv
         faJu9h7yKkbgUMLW3m8fU3Aj3TQCIs5DSxTQKCPQGHA5JVWeYBDsnlya8eYjs+/N99f3
         YbAB9aWYSzXEQLMWMYUQIMWUtwjE1RvPA9lSByiZBbGlVN0yIv4/xrBRobpB4LrAXuzj
         FfJwCGbB8a9RluyrJIbHu2Oc53aPauuozdC5gTuTxtQgimqwKenhDE7Gtla1NmQerfYF
         xZa7smRLIDFviLkEJWG2jf7OlzZXq+GQD3lJhgcqJYJRBmEg87FPi5FfxO4dTRc7QcvJ
         T4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441080; x=1760045880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3UYjs/DjWtPFJ9SkgiQewKjh9UT4jabvAen7EJXFzrU=;
        b=XOkLwysWSWwtOzZCdA4kkx3uO5EdJ+WPljmh3pUE2t+vOrlwKFXD6/lq/LGZ9+Ax4P
         o5xmERCTYz2R7raWvsjcPyXIjXsDYmwYSU1+v8qU5gbkSh8n39f62QmreaDrgIoRBoXq
         HVrEcbQPy39beKCnJ3ofYx1L0IoKyAti9YjLDa1PR5fWMFVLOvdcKsq/TwtMTCoArItR
         nH9Adg17j7nSdcNST6LXZ/9aYZ0UR04xmdMV+VlhAf/J70V3LmnxbWUoN8Aivk8JSV+W
         rVmhC27E0oW9/t3TgKH5GaOF7Pkg6TgsFp4Lu7glFTMXwL2WsFGuinlV+qDs9dPG2mK6
         jRCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzIaT4EbNCbEboIJEp1iWySfCE2uReK8J7uESrMzVcsGWkzf+Zd5mfYIPYKFftDL2C9PkQU1pK31NsN+s=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxdRJ4xn8NlVDf48iaEU0iLnHuen7GgTcQ5rBefKvEI/6iMU3ya
	c0SBttNRr4+pdF9Za4G9zfiHs48CgWQ14p477QAHlsujgtomVkPnFW09
X-Gm-Gg: ASbGncuVs+TI1YvLeHgBljBWw7aGTzEs9nd6vGNDvEjxr/Lird8wf+ytbKDspMM7q7Z
	bDfc1DMN1LzxqA5C2USPN8xlngyhBbmSyIQgxeJcIPxE99++A3Ol5P8hhJLlxTUDiOsxXZvH05W
	+rCn8JEjHzHHxWcgGEG+nu+j4oPQouj61UE2jvo45FZ2tFQ/I6aNFn9CSQkNz+dtZ9uzzKy2rrz
	V+xv4YGdCOu0R5GFbFJNfdhC3TtcPWeksBXPwUry8j42adRXAYUbf98Nly7OyPwIIcQ/vQfkvkl
	Rh7sByZkuBe5NxhSKWxBflcBmfmayfZADLE1aE0i4HxkyrhsUv3K4hsdd4O8NEk/zxYcgt176Q1
	CTVrotKlUwLK/OXdX7kSsYBXUxyftFxKcVgFLop2HLVk9yw0k0d7SYasDpc0=
X-Google-Smtp-Source: AGHT+IGfpeSt72PLiRG8302u7jW0eS5cM/tPuBTjoCfYGBR7WBrL3m9GghHnqqRwzstji5FK0/L81g==
X-Received: by 2002:a17:903:2ad0:b0:264:70e9:dcb1 with SMTP id d9443c01a7336-28e9a6fdf1bmr8314995ad.56.1759441080436;
        Thu, 02 Oct 2025 14:38:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d122d96sm30394595ad.32.2025.10.02.14.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:37:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:37:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eddie James <eajames@linux.ibm.com>
Cc: linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew@codeconstruct.com.au, joel@jms.id.au,
	chanh@os.amperecomputing.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v7 RESEND 4/7] dt-bindings: hwmon: Move max31785
 compatibles to max31790 document
Message-ID: <4b617318-f76e-47b0-9744-6a79803a149c@roeck-us.net>
References: <20251001144441.310950-1-eajames@linux.ibm.com>
 <20251001144441.310950-5-eajames@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001144441.310950-5-eajames@linux.ibm.com>

On Wed, Oct 01, 2025 at 09:44:38AM -0500, Eddie James wrote:
> The binding for the max31785 is the same as the max31790, so just add
> some compatible strings for the max31785 chip.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied to hwmon-next.

Thanks,
Guenter

