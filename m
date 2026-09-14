Return-Path: <linux-aspeed+bounces-4990-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3AEC88E75
	for <linux-aspeed@archiver.kernel.org>; Tue, 15 Sep 2026 00:01:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkMcc30b7z2y8G;
	Tue, 15 Sep 2026 10:01:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=205.220.180.131 arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789380599;
	cv=pass; b=Tdmh+Mi4ULw5h1Awk4nkfAdyqF++f7HJk1n7FMmusULVXfJh+qlkzx1yEAQorOfiJQCGnbFGzltsswwJ6aFMHLYg0qJr2EI78KhUTsvOvnpF2oxzEUzhm/WOJA3ED8tTQ63RiXjoJmGVHOVKI0Lm4NbG0Er4Ca68m4oEUL9clqkGMSnMKmTtN+uQZphiRqLeA3yb2Z+7mzWlAW18CiNdnbjPt9CKbgQG0uh2r0JyTqjlu3I6XXuFVM0e5RSqr67KeVwnYx7kKwH9ljLQdXQIXOpm6Hqzr6ZIBeNC22Yv5/iLnyPCU/6976FReX2ZwKP9SiYkhglbyNWXQ6yvYPS/Wg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789380599; c=relaxed/relaxed;
	bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYK8ziC4n3LBnXvuAtFnzzLvlYEsKL6mko8/qXLGadJ26boMmgR8B3t85WNQYG1eXlIUtE6g21fpL0O/9AxSx1neG81zxmyQ3jZ1qbTiYaj8ApkpnCjwdNS57TanbOJX+oBNSKsGQL/2gMte7yxa65YosIyk2Y+fZ/Sb5o3yJJItcCO7EGkmWPHwePrstX4VSsYteOm7qb3WIjZyL0KJlaOpMUKBd55sjEfgldBWEoxP8dRWKKPpPlIY0VF8PQ84T/mT+GC6aqT5gB6Yq6ziWV8zJtiUF2KlMCix9sj/UN3iijkQaQVIlNsoyF0sQ0Tfw5ol7Xtyk+XSVV1NtmeJAw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd1MyXOo; dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iC2TZ167; dkim-atps=neutral; spf=pass (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cd1MyXOo;
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iC2TZ167;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=oss.qualcomm.com (client-ip=205.220.180.131; helo=mx0b-0031df01.pphosted.com; envelope-from=ulf.hansson@oss.qualcomm.com; receiver=lists.ozlabs.org)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hk19L39l7z2xBK
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 20:09:56 +1000 (AEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E9naha773219
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 10:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=; b=cd1MyXOoNTeupvMQ
	1vlzwu5O9fxeTHN1l64x7hYxAujJXzKCr2fbv9EZX3jztY8QgA3bEZef7KsAMG0Y
	TpweHent0/06oxXjwNiUy69cLhEs3kQa+1FH0mH6pmWttYiTZirymHZCQliftGJK
	xD/mTq439qWXuH534GY9JYVWAu9ZMnjUpgL9Mfhbyful2WZqAvrC8uES+ZxUGAGE
	Ns9w53JtZXdxDqMJwCIuhBgM/xW8vEWWGbQaDEjzKqx7a8UwaGrBeh0bD59fG0Wc
	qmpoz10K8tCCzLSstgxH7TdoWJ4m2zAJerQpmC4T7IM94HQn3vHbZG9Hvrs6Dse9
	3CyQTw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevrav9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 10:09:52 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1b8088203so3052098a12.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 03:09:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789380591; cv=none;
        d=google.com; s=arc-20260327;
        b=XvEF1kMEgDURxZRC/eJ7zWiyQLuy/xuck6+0S0OGJijqrSnttOsb2BXs2jGK7A0ejM
         DHRWFk2SmbLd8aJcRb9b+6fZ0OcGfTJumcRSnz5hpO84OuHjA4obGvd+/bU6Cb4/b9BR
         H5CkX9IwHjZ3n27rgdv5mKXwOA2o95y5I5nsLdmAvvBMR+Ya1NhTX3DtkNHcjOgSUqMa
         Le5BwAsbA5PLxYFhOJzEHetPnXpNNE3QP3zmGz0KXIx9rpSNxTegFng7xY/6FMpukzQI
         95xnI7tWgj6uRcCOAYZIN6MGARevqBv4oZZKmRGkU7sFg8qHykScqXg9LHEg+lhZaUDm
         62sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        fh=OdFbA1bgpM2fxOCz4fCTPRYxyNuojancwXtOanrK5mo=;
        b=IvDAWIK75ItCoWI/crEU9NmMp69kAgEZv7/oJ1uQWBloEIQEtqQvVkdDRoQTH0H3U6
         Ywaxi3SzjBYSe2/CM0ZgsWF0erhzrwpVqBpBo3ka3n6mJQq4MLlQk14436l9u+vd+2Xa
         ziSjthNKX5BvH9aPH61Ud38qTMHODGxA0o3gkvlow0LgIWUx7gt0wShMhahj4EiejLs1
         kCTR7gMcC1herEhHec5qLfJatfqNK6coQtGd9ln6WerzQS156oToouKSNX8kYzOEQs3g
         TkXaE7x1FD7qsLBnpn/o/bQksWEj352iBPlq0y/7u8an/hGjigpTxrvLCV3sYz2UIPjV
         wJBg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789380591; x=1789985391; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        b=iC2TZ167ghO1gmrB/6K3Ar3UVmHw/GwQP7w+0TwaI4qeCbe3l1Rn/uwXbTLuitU1zA
         LRZYhSIcyYefl5uHEFdPs6qgtOCCjqpT4hQNqUTpNgwi++A91BZ/DT435p9ne8BCiLH2
         J2Q8oCDW1lZa5t82n+UvVtRZsTDySNxO++2yedCih8Go4kLIcjecazEn03nwm/6WrN2w
         mvpIK8seH7MoIp22BjuW3j1pjGMQAcHAio+HJPXw0zqaZ2xw8O4rpGDHWigV1jYHqtYu
         sXoSepRiskM/JRFrSLnN0HWEY9IphcLlQdds+p1RtDA5CZdQ7EPsJJU7s/d/HWXXwyWx
         APoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789380591; x=1789985391;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M12Cwh3ZRT6ahFa1J+DXeT+ShEs3pxzKaObkmR8W2j4=;
        b=qS0UPOgANkFuGEtjvOMspEqnEPio6cK+2uB8ascUgvN0Ss5c7qijbDs75bS2TdP8PD
         JJgysU6qKu/rmljzPIKxD7hgWSTZz01x8xiNkAqhr3vhgZ21xh6n3KZHFj0PtjGsgT+M
         uD89uoL4NLKcntRAxD5R6jHa52DzWcHs5SYIc4jOJeI2ZYCehwPUg17DlsOI7XsRQyUy
         h0RjZzD9trO21fYPkp3CuDaMsr+i9ExR5CEZcLU/AX0qi1kiKB3BFQnCPfbHIF85wSbQ
         nqoLDbBZbB3KWMOCL9wVJIMoEA35bFKM8/sQBPxw8cZyRi2XDL2GLgBijDThfPlbDwcg
         QHZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzUyxK5n9xwpXlphn1XnoyAUGPRJXWZdhO6EgOyBkwRqzvVr9lUYVPzpp/UJU/sDzFlR/bemuaXRa7YOg=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lW5OZjFSgWYTlkZN8om+wvMZR7mWEM98qdCoS3DrFcb6tfe98+
	hhIjDV0zYqUy/ov4iqthRREnSrKupsb/zUEkB/RzVPgWtsJGyMB15TYcYezkWmUA4pVd6d8NdxA
	j3Y7cfAKQUmT+DuB93nOXUtI6ncyBu+N36eFmIq7M6eddVUO+o45HTRHIqG/VLuG+4ofynkP5/J
	bwwinLHZEaIOY9FgzWEly4PfK5CB6zcVHUXCW1UMKkLKw=
X-Gm-Gg: AYBFou2yiPjirxbVHW2gopl/gd9gvCciTyX5PdLmMz+G4utiDOMSpPLP082pwXHXtMJ
	T8GyVQjiZny6ziioSi8ckxvDHqhQ51Tm3T47FAAOWyd9zE4vyJXsT4j9DYnKUnbmlhoNMLnayaT
	MXIjjth4LWIO+B2kpdnP+0j4Fw1LikX0UNM7pG6upKzOPm5/iZXw+r0XmlIQ==
X-Received: by 2002:a17:903:b8e:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2dd6c73445amr40754535ad.15.1789380591349;
        Mon, 14 Sep 2026 03:09:51 -0700 (PDT)
X-Received: by 2002:a17:903:b8e:b0:2d8:d4d3:3fbb with SMTP id
 d9443c01a7336-2dd6c73445amr40754055ad.15.1789380590927; Mon, 14 Sep 2026
 03:09:50 -0700 (PDT)
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
References: <20260913223538.91579-1-mhun512@gmail.com>
In-Reply-To: <20260913223538.91579-1-mhun512@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:09:39 +0200
X-Gm-Features: AcwNN1UKvtuQqttQbqd993vkvprGXBb1M6WJsKdk_G31r2WFSme_tK7rANZaz_8
Message-ID: <CAPx+jO-Vck8PzQjg4yn6ft4Rms2_9eSOLpbAQryMLChY87BPMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-aspeed: Remove children before releasing
 SDC resources
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
        Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: Fqw_4iVibjeOK2d22TrhTJcNxy0LPw1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfXwFpZPfM4z/x7
 jORIg0wF/7fm+xuWqCOrO0i85S9bAwcQlbTJmctzAwKbrjeJavb3/RV6wN/Llb9cCjhyKyR4HmK
 OYq0JElYK3s0lllNlvlmgf7ZHqVLovk=
X-Proofpoint-GUID: Fqw_4iVibjeOK2d22TrhTJcNxy0LPw1h
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa7c7f0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=_cOgsa2NosUwn6K3uuEA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDE0NSBTYWx0ZWRfX/SnEhGfEzN02
 7TKMpjEH8PZcefgQE8YpjLqo+jNDsE0NIxzx4uekW/gwwWeMJz3AFzBKtrYRa8yUUOVfd5nA++v
 L8JmAU3eEfis7oaEFdAxm+HbET91vFzyHUu3D7DnpEPakvSbTH9LA8YmkFBw2rD87PUoWSatxrA
 aywTgtNAQze+sPkf/LsHGjN7qZNyj39L8UxjLNOnL+TjTO7sm4oTlYUh+HQFtIW0Hq0jpUlTvb+
 bRZeCDM4RPiYRo4Ez9tyyXBrQ3ZHRn2ayWfgwDAgNAn/69Odw7/w0S29khmbxLoL/0dm6auY8G2
 wQ5SefdiozSh2RdbukxbrIyc+L6i0fmNqq7HHXoOugveEO5e6/AF/kGSkdXWBxcdobGId48aBJf
 ihPcFDVHcRsreXDAz4fXpxh2wKoDBLKQ32bxmtuwkVhsxXVrRzBfbTUYpIUf9K2354pgl+eU+tu
 JerdZj/8pUIDvW9lndg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140145

On Mon, Sep 14, 2026 at 12:35=E2=80=AFAM Myeonghun Pak <mhun512@gmail.com> =
wrote:
>
> Probe failure and removal leave SDHCI child devices registered after the
> parent clock and managed resources are released.
>
> Unregister the OF children in reverse order before disabling the parent
> clock on both paths. Use of_platform_device_destroy() because manual
> child creation does not set the flag required by of_platform_depopulate()=
.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: bb7b8ec62dfb ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD=
 controller")
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> Assisted-by: OpenAI:GPT-5.6

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> Validated with an ARM64 W=3D1 object build and strict checkpatch.
> No hardware runtime, probe-failure injection or unbind testing was done.
>
>  drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index f5d973783c..d317626feb 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device =
*pdev)
>                 cpdev =3D of_platform_device_create(child, NULL, &pdev->d=
ev);
>                 if (!cpdev) {
>                         ret =3D -ENODEV;
> -                       goto err_clk;
> +                       goto err_children;
>                 }
>         }
>
>         return 0;
>
> +err_children:
> +       device_for_each_child_reverse(&pdev->dev, NULL, of_platform_devic=
e_destroy);
>  err_clk:
>         clk_disable_unprepare(sdc->clk);
>         return ret;
> @@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device =
*pdev)
>  {
>         struct aspeed_sdc *sdc =3D dev_get_drvdata(&pdev->dev);
>
> +       device_for_each_child_reverse(&pdev->dev, NULL, of_platform_devic=
e_destroy);
>         clk_disable_unprepare(sdc->clk);
>  }
>
> --
> 2.50.1

