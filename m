Return-Path: <linux-aspeed+bounces-5038-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E86C982FF
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 13:21:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq13B2vSDz2yFK;
	Tue, 22 Sep 2026 23:21:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790083318;
	cv=none; b=etW3nr2pRD8RTDucwI0JCa/l3/n/+xtp7LXwlF2MSo+1SrclSRQ4znPBI31xKX+/PJzF/ACsnbg1zmwKglxSty+mnhFJ3IlHND0QGIgbgVfjlntu4BLOtttf8Q4/6uIQ3ardQw3AGLBhd9iSje8YvqsSBcz9uzcUwdnatDMVLt5MObWOaL7PY1b2d2bW6OLze7qf2YsrcU+UifC5bYcINjFsa9O4hg53FpE7LiuGyj3fXXwBsk0DFyYBt5RuDHSJPQDzGvpLuPYiRafnJRdmV/rjxtAOoKaVBflYBk4w9Sws+l8m9wj+2ncQ6J7sTIOtG20U+pUmrJLNDTVTQXqo3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790083318; c=relaxed/relaxed;
	bh=0lryHDGBzH0yt6rZeb3UHP0vuOu2NeBF2okLNiTIg9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7JNKk9z2OmxprFT1LgzO7148yUmHvX5pf56qzU8B4yThKhVPj3SWtxYCZ+EXnxILIuGb1IahF2GZBYjWLicah0Z2zeHiwN+JzO1ws7HmocyOPIhQtucAnEKocOS5w7ZFMSLzHiDAOWDZqDfzkHGNiSD5UoyUAHAiYWMHtlXV7Nmw/IPk96uC2zOX8tcIH2kijpMkUqYPZK44uEqCqBFAhaPyzSbmRsgfL/SS8Qqi/TnQ26+gelyamGyiwyyH0DoHYNEtM27E41v7yDQOeLHNGiKIEwRb3W7SB+uc/4KLGmIV/khxHwTPttA3T7ota2GwqRZgiGsST1P7eP/dLJ3yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=aQbgHxn+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=aQbgHxn+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq13808MZz2xGr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 23:21:54 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso59029285e9.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1790083311; x=1790688111; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lryHDGBzH0yt6rZeb3UHP0vuOu2NeBF2okLNiTIg9o=;
        b=aQbgHxn+2b26VIIgOPYW38ckhAqWk9Ff8flnWPZEuUET8qRMr9ryQ1FixozMWY+fhQ
         YUi7WiK5ia0UQQUKnnMuX5pv2TPnJH7y7U37ku8Ihe9GDIVZnHojcJ1Dof1lMTDknjgh
         xN4rbvg5NBGdHJSzXMEAqPCHTBSxYsxSuulY0ZEmqj7uOQ9VsdUCuslfpG779AzwzSkR
         wMMkICZbWqqgImMYVt/tsswBu7xXcEdabO/6jp0bYBS1bv1pxqNfNeh/o+CMuyv6uBIn
         OWjsgMUo2CHSDsfb0IPsigR91TkZl4UL/vY9hrH2t2qQBrcIUlTp/Z2yMeNs/cKJ6YjV
         +Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790083311; x=1790688111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lryHDGBzH0yt6rZeb3UHP0vuOu2NeBF2okLNiTIg9o=;
        b=2DrgkpsGYF1kcmK/FP4/u6vTiu8SrHhgtQ/q2zl9u7shtgJSZhVk5TERwJc7fLWqCO
         v39YxQd4wP4qiawd20HBfvVNGkjN/XI8r+h8BKpSZVR332a2nImqHe2SLMU7z00pMaFY
         DW9DI31qtqOEdzCADeUBVdKaz5tPmQalCYEaCuHdOWcX+u2WUZIkfUUlHLfngAy/naOs
         LU3V+QTO41AtZavsc69PUl+fd3vzMQ+a0mAu6Wg6U1qGyM7ZivHEmFtQmScBqvLi2X9A
         aGz9nM0cQ7aA1c2ZPbiF1gtkv6z2Hdf+oIeomSHmLWSV1e8mW02/csIkIheOQKKiGZeA
         quPA==
X-Forwarded-Encrypted: i=1; AKwUvBxPox/QNEdxzsRZluzKzgJtgNZQoAz6Nt0GXMbsVpF41aYXg7mnUIgQvFQ8DCgx3Y61vhRQF04ppo1i4Ho=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mA9I0+3KywSuwnJM8Qc1vP9B1CCiXITdf8SmJusXNnUAWpa7ew
	OeHD1/J8H9RQtsyBD1Tkiq/qthdIyeCnj6TbGn0UtYfwlFVtvbDH4YNFUJqzk5pMCjg=
X-Gm-Gg: AYBFou2X19DAqr+GmsSa8l/n29TBQMez2YhpDX7Mgmy2PC4j8j2143vfJMPihw0pA4C
	5gKxYl/3SmgvZ445BByZj3jFmQjicKK2ipFxchOpSLnm1QAJEoXeJ5w9Edglsw0lQqWSDn12Kg9
	KHEB0ff58Z1bj5qphqIkFflXCQ+u7M2IyYauIDKQhGWubM/vyyzfyfE64wUUpU3G77cAwhh12DG
	kjXPcTvJ/Sk0RjOIJbzJxt5tiaP2AWTMgN7JNQj1wPK18qneV43gsX8yKH68irVYFKqYb2FNH52
	UeN1OdJmNStLFiYB3JD3wsOkutpwET6L6Fjrm/jj64zGywi9Je68+T7/5qlLzbMY5FvzHO1Ga4I
	+KAZuHlV/gBbDYgQMyLUvMFy+TG+X6cCw5+q8iq4KgfB/hoySxiwhWwmMtcxpWQiQo9LDYt/wIW
	l8oJnBiI81HLJGcvCwBcNdL7sShYerSm/Gld6xUE6y2hRqaNJjwbzYfCoa87NJ8SWaTIYK53Ida
	hAkmSBHSywalYSigE1lqZyP/USqKhdu2DruQSBSUe7ewm3JfZhHv3VWA2Epbg==
X-Received: by 2002:a05:600c:8b03:b0:499:a277:e8b5 with SMTP id 5b1f17b1804b1-49fc566e609mr187887745e9.3.1790083311001;
        Tue, 22 Sep 2026 06:21:51 -0700 (PDT)
Received: from ?IPV6:2a01:599:842:c46f:7b1d:31f2:7a17:2f4c? ([2a01:599:842:c46f:7b1d:31f2:7a17:2f4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdad2a3e0sm70823335e9.5.2026.09.22.06.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 06:21:50 -0700 (PDT)
Message-ID: <8cb38ff6-1210-4c5a-b0bc-b0b50dd2b9aa@9elements.com>
Date: Tue, 22 Sep 2026 15:21:48 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
 support
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, joel@jms.id.au
Cc: andrew@codeconstruct.com.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com,
 andrew@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
Content-Language: en-US
From: Tan Siewert <tan.siewert@9elements.com>
In-Reply-To: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 2:34 PM, Prasanth Kumar Padarthi wrote:
> Add support for the ASRock Rack B650D4U BMC, based on the ASPEED AST2600 SoC.
> 
> The series adds the board compatible string and describes the BMC memory, SPI NOR flash layout, UART console, GPIO line names, graphics reserved memory, I2C EEPROM, and MAC0 connected to an RTL8211F Ethernet PHY.
> 
> MAC0 obtains its MAC address from the EEPROM on I2C7 and uses RGMII-ID mode.
> 
> Changes in v7:
> 
> * Correct the GPIOP bank line names for the reset, power and NMI button/control signals according to the confirmed board mapping.
> * Remove the obsolete GPIOF5 reset-button line name.
> * Leave the binding patch unchanged.
> 
> The B650D4U DTB builds successfully using aspeed_g5_defconfig.

What? The B650D4U has an AST2600, so using `aspeed_g5_defconfig` means 
you're using a config set for the AST2*5*00...

Also, please preserve the trailers from previous serieses (i.e. Andrew's 
Reviewed-by trailer) if you don't change anything significantly for the 
parts that got reviewed.

Tan

