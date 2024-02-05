From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Mon, 5 Feb 2024 06:59:27 +0000
Subject: [PATCH v13 1/3] dt-bindings: hwmon: fan: Add fan binding to
 schema
In-Reply-To: <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
References: <20240124060705.1342461-1-billy_tsai@aspeedtech.com>
 <20240124060705.1342461-2-billy_tsai@aspeedtech.com>
 <e1b1c69f-a2ff-4fa5-80a6-3ff0a3de6ce6@roeck-us.net>
Message-ID: <OSQPR06MB72522452AF463172AD54D4EA8B472@OSQPR06MB7252.apcprd06.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Add common fan properties bindings to a schema.
> >
> > Bindings for fan controllers can reference the common schema for the
> > fan
> >
> > child nodes:
> >
> >   patternProperties:
> >     "^fan@[0-2]":
> >       type: object
> >       $ref: fan-common.yaml#
> >       unevaluatedProperties: false
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

> v12 of this patch got a Reviewed-by: tag from Rob.
> The tag is gone in this version, presumably meaning that there
> was a substantial change.

> I don't normally do this, but I downloaded v12 and v13 and did not
> find a single change. Why did you drop Rob's Reviewed-by: tag ?

Hi Guenter,

The fan DT-binding for version 12 is identical to that of version 13. I
apologize for forgetting to include the 'Reviewed-by' from Rob when
preparing version 13. I will make sure to include it when sending
version 14.

Thanks
